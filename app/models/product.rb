class Product < ActiveRecord::Base
  attr_accessible :description, :discount, :name, :price, :available, :popular, :brand, :size, 
                  :sub_sub_category_id, :photos_attributes, :stock

  has_many :line_items
  has_many :photos

  validates :price, :presence => true

  belongs_to :sub_sub_category
  accepts_nested_attributes_for :photos, :reject_if => :all_blank,
                                :allow_destroy => true

  before_destroy :ensure_not_referenced_by_any_line_item

  define_index do
    indexes :name
    indexes :brand
    indexes sub_sub_category.name, :as => :sub_sub_category_name
  end
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      file = File.open(File.join(Rails.root, row["image"]))
      row["image"] = file
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end

  def self.to_csv(options = {} )
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.filter_by_stock(threshold)
    Product.where("stock < ?", threshold)
  end
  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end

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
    indexes sub_sub_category.sub_category.name, :as => :sub_category_name
    indexes sub_sub_category.sub_category.category.name, :as => :category_name
    indexes sub_sub_category.name, :as => :sub_sub_category_name
  end
  def self.import(file)
   # spreadsheet = open_spreadsheet(file)
=begin
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      file = File.open(File.join(Rails.root, row["image"]))
      row["image"] = file
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
=end
    excelsheet = Roo::Excelx.new(file.path, nil, :ignore)
  #  header = excelsheet.row(1)
    (2..excelsheet.last_row).each do |i|
      row = excelsheet.row(i)
      product = Product.new
      product.name = row[0] if row[0]
      product.size = row[1] if row[1]
      product.price = row[2] if row[2]
      product.brand = row[3] if row[3]
      product.discount = row[4] if row[4]
      product.description = row[5] if row[5]
      product.stock = row[6] if row[6]
      product.sub_sub_category_id = SubSubCategory.find_by_name(row[7]).id if row[7]
      product.save!
      image = File.open(File.join("/home/luojm/products_pic/", row[8]))
      product.photos.create(:image => image, :color => row[9])
      for i in 10...row.size()
        if row[i] == nil
          break
        else
          image = File.open(File.join("/home/luojm/products_pic/", row[i]))
          product.photos.create(:image => image, :color => row[i+1])
          i = i + 2
        end
      end
    end
=begin
    CSV.foreach(file.path, headers: true) do |row|
      debugger
      product = Product.new
      product.name = row[0] if row[0]
      product.size = row[1] if row[1]
      product.price = row[2] if row[2]
      product.brand = row[3] if row[3]
      product.discount = row[4] if row[4]
      product.description = row[5] if row[5]
      product.stock = row[6] if row[6]
      product.sub_sub_category_id = SubSubCategory.find_by_name(row[7]).id if row[7]
      product.save!
      image = File.open(File.join("/home/luojm/products_pic/", row[8]))
      product.photos.create(:image => image, :color => row[9])
      for i in 10...row.size()
        if row[i] == nil
          break
        else
          image = File.open(File.join("/home/luojm/products_pic/", row[i]))
          product.photos.create(:image => image, :color => row[i+1])
          i = i + 2
        end
      end
    end
=end
  end

  def self.to_csv(products)
    CSV.generate do |csv|
     # csv << column_names
      columns = ["name","size","price","brand","discount", "description", "stock", "category"]
      csv << columns
      products.each do |product|
       # csv << product.attributes.values_at(*column_names)

        arr = []
        columns.each do |col|
          if col == "category" && product.attributes["sub_sub_category_id"]
            arr << product.sub_sub_category.name
          else
            arr << product.attributes[col]
          end
        end
        photos = product.photos
        photos.each do |photo|
          arr << photo.image.to_s.split("/")[-1]
          arr << photo.color
        end
        csv << arr
      end
    end
  end
=begin
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then CSV.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
=end
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

class ProductsController < ApplicationController
  # GET /products
  # GET /prooducts.json
  before_filter :authenticate_user!, :except => [:show]
  def index

    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    if params[:search] != nil
      @products = Product.search(params[:search])
    else
      @products = Product.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.csv { render text: @products.to_csv }
      format.xls { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @line_item = LineItem.create!
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new

    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def import
    authorize! :manage, @product, :message => 'Not authorized as an administrator'
    Product.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end
end
class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  before_filter :authenticate_user!, :except => [:new, :create]
  def index
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    if params[:search] != nil
      @orders = Order.search(params[:search])
    else
      @orders = Order.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @order = Order.find(params[:id])
    store_location
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to root_url, :notice => "Your cart is empty"
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to root_url, notice: 'Thanks for your order, we will contact you soon later.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @order = Order.find(params[:id])
    @order.process();
    @order.processed = 1;

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def finished_orders
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @orders = Order.find_all_by_processed(1)

    respond_to do |format|
      format.html {render 'orders/index'}
      format.json { render json: @orders }
    end
  end

  def unfinished_orders
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @orders = Order.find_all_by_processed(0)
    respond_to do |format|
      format.html {render 'orders/index'}
      format.json { render json: @orders }
    end
  end
end

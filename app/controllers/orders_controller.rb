#encoding: utf-8
require 'will_paginate/array'
class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  before_filter :authenticate_user!, :except => [:show, :new, :create]
  layout "home"
  def index
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    if params[:search] != nil
      @orders = Order.search(params[:search])
    else
      @orders = Order.all
    end
    @orders = @orders.paginate(:page => params[:page], :per_page => 15)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_ids = session[params[:id]].to_s
    @order_id_arr = @order_ids.split(",")
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
      redirect_to root_url, :notice => "对不起，您的购物车是空的"
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
        if (session[:uid] == nil)
          session[:uid] = SecureRandom.hex(16)
        end
        if (session[session[:uid]] == nil)
          session[session[:uid]] = @order.id.to_s
        elsif
          session[session[:uid]] = session[session[:uid]].to_s + "," + @order.id.to_s
        end
     #   session[:order_id] = @order.id
     #   UserMailer.new_order_email(@order).deliver
        format.html { redirect_to root_url, notice: '感谢您的购物，我们将会在一小时之内送货上门' }
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
    @orders = @orders.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html {render 'orders/index'}
      format.json { render json: @orders }
    end
  end

  def products_sended
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @order = Order.find(params[:id])
    @order.processed = 2
    @order.save
    respond_to do |format|
      format.html { redirect_to orders_url, :notice => "订单状态已改为送货中" }
    end
  end

  def unfinished_orders
    authorize! :manage, @order, :message => 'Not authorized as an administrator'
    @orders = Order.find_all_by_processed(0)
    @orders = @orders.paginate(:page => params[:page], :per_page => 15)
    respond_to do |format|
      format.html {render 'orders/index'}
      format.json { render json: @orders }
    end
  end
end

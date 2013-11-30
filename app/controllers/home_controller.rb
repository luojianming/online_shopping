require 'will_paginate/array'
class HomeController < ApplicationController
  def index
    @categories = Category.all
    @banners = Banner.find_all_by_visiable("true")
    if params[:search] != nil
      @products = Product.search(params[:search])
    else
      @products = Product.all
    end
    @products = @products.paginate(:page => params[:page], :per_page => 8)
  end

  def about
  end
=begin
  def contact
    @constant_text = ConstantText.find(1).contact
  end

  def pay
    @constant_text = ConstantText.find(1).pay
  end

  def store
    @constant_text = ConstantText.find(1).store
  end

  def who_we_are
    @constant_text = ConstantText.find(1).who_we_are
  end

  def how_to_buy
    @constant_text = ConstantText.find(1).how_to_buy
  end

  def delivery_area
    @constant_text = ConstantText.find(1).delivery_area
  end

  def privacy
    @constant_text = ConstantText.find(1).privacy
  end

  def changes
    @constant_text = ConstantText.find(1).changes
  end

  def cookies
    @constant_text = ConstantText.find(1).cookie_state
  end

  def welcome
    @constant_text = ConstantText.find(1).welcome
  end
=end
end

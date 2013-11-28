require 'will_paginate/array'
class HomeController < ApplicationController
  def index
    @categories = Category.all
    if params[:search] != nil
      @products = Product.search(params[:search])
    else
      @products = Product.all
    end
    @products = @products.paginate(:page => params[:page], :per_page => 8)
  end

  def about
  end
end

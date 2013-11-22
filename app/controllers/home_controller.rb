class HomeController < ApplicationController
  def index
    @categories = Category.all
    if params[:search] != nil
      @products = Product.search(params[:search])
    else
      @products = Product.all
    end
  end
end

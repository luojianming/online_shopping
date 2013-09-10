class HomeController < ApplicationController
  def index
    if params[:search] != nil
      @products = Product.search(params[:search])
    else
      @products = Product.all
    end
  end
end

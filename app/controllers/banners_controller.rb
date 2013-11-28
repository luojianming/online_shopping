require 'will_paginate/array'
class BannersController < ApplicationController
  before_filter :authenticate_user!
  def new
    authorize! :manage, @banner
    @banner = Banner.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    authorize! :manage, @banner
    @banner = Banner.find(params[:id])
    render 'edit'
  end

  def index
    authorize! :manage, @banner
    @banners = Banner.all
    @banners = @banners.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
    end
  end

  def update
    authorize! :manage, @banner
    @banner = Banner.find(params[:id])
    respond_to do |format|
      if @banner.update_attributes(params[:banner])
        format.html { redirect_to banners_path }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    authorize! :manage, @banner
    @banner = Banner.new(params[:banner])
    respond_to do |format|
      if @banner.save
        format.html { redirect_to banners_path }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    authorize! :manage, @banner
    @banner = Banner.find(params[:id])

    respond_to do |format|
      if @banner.destroy
        format.html { redirect_to banners_path, notice: 'Banner was successfully destroied.' }
      end
    end
  end

  def unvisiable_all
    authorize! :manage, @banner
    @visiable_banners = Banner.find_all_by_visiable("true");
    @visiable_banners.each do |banner|
      banner.visiable = "false"
      banner.save
    end
    redirect_to banners_path
  end
end

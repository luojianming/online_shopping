class ShortSupplyRegistrationsController < ApplicationController
  # GET /short_supply_registrations
  # GET /short_supply_registrations.json
  before_filter :authenticate_user!, :except => [:new, :create]
  def index
    authorize! :manage, @short_supply_registration
    if params[:search] != nil
      @short_supply_registrations = ShortSupplyRegistration.search(params[:search])
    else
      @short_supply_registrations = ShortSupplyRegistration.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @short_supply_registrations }
    end
  end

  # GET /short_supply_registrations/1
  # GET /short_supply_registrations/1.json
  def show
    @short_supply_registration = ShortSupplyRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @short_supply_registration }
    end
  end

  # GET /short_supply_registrations/new
  # GET /short_supply_registrations/new.json
  def new
    @short_supply_registration = ShortSupplyRegistration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @short_supply_registration }
    end
  end

  # GET /short_supply_registrations/1/edit
=begin
  def edit
    @short_supply_registration = ShortSupplyRegistration.find(params[:id])
  end
=end
  # POST /short_supply_registrations
  # POST /short_supply_registrations.json
  def create
    @short_supply_registration = ShortSupplyRegistration.new(params[:short_supply_registration])
    @short_supply_registration.status = "false"

    respond_to do |format|
      if @short_supply_registration.save
        format.html { redirect_to root_path, notice: 'Short supply registration was successfully created.' }
        format.json { render json: @short_supply_registration, status: :created, location: @short_supply_registration }
      else
        format.html { render action: "new" }
        format.json { render json: @short_supply_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /short_supply_registrations/1
  # PUT /short_supply_registrations/1.json
  def update
    @short_supply_registration = ShortSupplyRegistration.find(params[:id])
    @short_supply_registration.status = "true"
    respond_to do |format|
      if @short_supply_registration.save
        format.js
      end
    end
  end
  # DELETE /short_supply_registrations/1
  # DELETE /short_supply_registrations/1.json
  def destroy
    authorize! :manage, @short_supply_registration
    @short_supply_registration = ShortSupplyRegistration.find(params[:id])
    @short_supply_registration.destroy

    respond_to do |format|
      format.html { redirect_to short_supply_registrations_url }
      format.json { head :no_content }
    end
  end

end

class ConstantTextsController < ApplicationController
  # GET /constant_texts
  # GET /constant_texts.json
  def index
    @constant_texts = ConstantText.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @constant_texts }
    end
  end

  # GET /constant_texts/1
  # GET /constant_texts/1.json
  def show
    @constant_text = ConstantText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @constant_text }
    end
  end

  # GET /constant_texts/new
  # GET /constant_texts/new.json
  def new
    @constant_text = ConstantText.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @constant_text }
    end
  end

  # GET /constant_texts/1/edit
  def edit
    @constant_text = ConstantText.find(params[:id])
  end

  # POST /constant_texts
  # POST /constant_texts.json
  def create
    params[:constant_text]["pay_state"] = params[:constant_text]["pay_state"].gsub("\r\n","</br>")
    params[:constant_text]["contact_state"] = params[:constant_text]["contact_state"].gsub("\r\n","</br>")
    params[:constant_text]["store_intro"] = params[:constant_text]["store_intro"].gsub("\r\n","</br>")
    params[:constant_text]["who_we_are"] = params[:constant_text]["who_we_are"].gsub("\r\n","</br>")
    params[:constant_text]["how_to_buy"] = params[:constant_text]["how_to_buy"].gsub("\r\n","</br>")
    params[:constant_text]["delivery_area"] = params[:constant_text]["delivery_area"].gsub("\r\n","</br>")
    params[:constant_text]["changes_state"] = params[:constant_text]["changes_state"].gsub("\r\n","</br>")
    params[:constant_text]["privacy_state"] = params[:constant_text]["privacy_state"].gsub("\r\n","</br>")
    params[:constant_text]["cookies_state"] = params[:constant_text]["cookies_state"].gsub("\r\n","</br>")
    @constant_text = ConstantText.new(params[:constant_text])

    respond_to do |format|
      if @constant_text.save
        format.html { redirect_to @constant_text, notice: 'Constant text was successfully created.' }
        format.json { render json: @constant_text, status: :created, location: @constant_text }
      else
        format.html { render action: "new" }
        format.json { render json: @constant_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /constant_texts/1
  # PUT /constant_texts/1.json
  def update
    @constant_text = ConstantText.find(params[:id])
    params[:constant_text]["pay_state"] = params[:constant_text]["pay_state"].gsub("\r\n","</br>")
    params[:constant_text]["contact_state"] = params[:constant_text]["contact_state"].gsub("\r\n","</br>")
    params[:constant_text]["store_intro"] = params[:constant_text]["store_intro"].gsub("\r\n","</br>")
    params[:constant_text]["who_we_are"] = params[:constant_text]["who_we_are"].gsub("\r\n","</br>")
    params[:constant_text]["how_to_buy"] = params[:constant_text]["how_to_buy"].gsub("\r\n","</br>")
    params[:constant_text]["delivery_area"] = params[:constant_text]["delivery_area"].gsub("\r\n","</br>")
    params[:constant_text]["changes_state"] = params[:constant_text]["changes_state"].gsub("\r\n","</br>")
    params[:constant_text]["privacy_state"] = params[:constant_text]["privacy_state"].gsub("\r\n","</br>")
    params[:constant_text]["cookies_state"] = params[:constant_text]["cookies_state"].gsub("\r\n","</br>")

    respond_to do |format|
      if @constant_text.update_attributes(params[:constant_text])
        format.html { redirect_to @constant_text, notice: 'Constant text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @constant_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /constant_texts/1
  # DELETE /constant_texts/1.json
  def destroy
    @constant_text = ConstantText.find(params[:id])
    @constant_text.destroy

    respond_to do |format|
      format.html { redirect_to constant_texts_url }
      format.json { head :no_content }
    end
  end

  def pay_state
    @constant_text = ConstantText.find(params[:id]).pay_state
    @type = "pay_state"
    render 'constant_texts/constant_text.html.erb'
  end

  def changes_state
    @constant_text = ConstantText.find(params[:id]).changes_state
    @type = "changes_state"
    render 'constant_texts/constant_text.html.erb'
  end

  def contact_state
    @constant_text = ConstantText.find(params[:id]).contact_state
    @type = "contact_state"
    render 'constant_texts/constant_text.html.erb'
  end

  def store_intro
    @constant_text = ConstantText.find(params[:id]).store_intro
    @type = "store_intro"
    render 'constant_texts/constant_text.html.erb'
  end

  def who_we_are

    @constant_text = ConstantText.find(params[:id]).who_we_are
    @type = "who_we_are"
    render 'constant_texts/constant_text.html.erb'
  end

  def how_to_buy

    @constant_text = ConstantText.find(params[:id]).how_to_buy
    @type = "how_to_buy"
    render 'constant_texts/constant_text.html.erb'
  end

  def delivery_area

    @constant_text = ConstantText.find(params[:id]).delivery_area
    @type = "delivery_area"
    render 'constant_texts/constant_text.html.erb'
  end

  def cookies_state

    @constant_text = ConstantText.find(params[:id]).cookies_state
    @type = "cookies_state"
    render 'constant_texts/constant_text.html.erb'
  end

  def privacy_state

    @constant_text = ConstantText.find(params[:id]).privacy_state
    @type = "privacy_state"
    render 'constant_texts/constant_text.html.erb'
  end
end

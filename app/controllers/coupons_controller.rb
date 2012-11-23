class CouponsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :new, :create, :edit, :update, :delete, :logged_shop]
  before_filter :authenticate_shop!, only: [:new, :edit, :update, :delete, :logged_shop]
  before_filter :signed_in, only: [:index, :show]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.where('shop_id = ?', params[:shop_id])

    respond_to do |format|
      format.html { show_from_resource('index', 'shop_index') }
      format.json { render json: @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html { show_from_resource('show', 'shop_show')}
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.json
  def new
    @coupon = Coupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = Coupon.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(params[:coupon]) 
    @coupon.shop = current_shop  # fix to @coupon = current_shop.coupons.build(params[:coupon])
    upload_file(@coupon)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to [@coupon.shop, @coupon], notice: 'Coupon was successfully created.' }
        format.json { render json: @coupon, status: :created, location: @coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.json
  def update
    @coupon = Coupon.find(params[:id])

    if params[:coupon].has_key?(:image_file)
      @coupon.image_file = params[:coupon][:image_file]
      upload_file(@coupon)
    end

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end

  def top
    @coupons = Coupon.all
    
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: [@new_coupons, @recommended_coupons] }
    end
  end

  def show_new
    @new_coupons = Coupon.all

    respond_to do |format|
      format.html # show_new.html.erb
      format.json { render json: @new_coupons }
    end
  end

  def share
    respond_to do |format|
      format.html # share.html.erb
    end
  end

  def ranking
    @coupons = Coupon.all

    respond_to do |format|
      format.html
      format.json { render json: @coupons }
    end
  end

  def logged_shop
    @coupons = Coupon.where('shop_id = ?', current_shop.id)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @coupons }
    end
  end

  # POST /coupons/use/1
  def use
    @coupon = Coupon.find(params[:id])
    @user = current_user
  end
end

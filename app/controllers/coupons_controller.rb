class CouponsController < ApplicationController
  before_filter :authenticate_shop! rescue redirect_to new_shop_session_path,
      only: [:new, :create, :edit, :update, :delete]
  before_filter :authenticate_user!, except: [:show, :new, :create, :edit, :update, :delete]
  before_filter :signed_in, only: [:show]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    image_id = SecureRandom.urlsafe_base64
    Cloudinary::Uploader.upload(@coupon.image_file, public_id: image_id)
    @coupon.image = image_id + File.extname(@coupon.image_file.original_filename)
    @coupon.shop = current_shop

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
    @new_coupons = Coupon.all
    @recommended_coupons = Coupon.all
    
    respond_to do |format|
      format.html # top.html.erb
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

  def current_shop_coupons
    @coupons = Coupon.where('shop_id = ?', current_shop.id)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @coupons }
    end
  end
end

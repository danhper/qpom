class CouponsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :new, :create, :edit, :update, :delete, :logged_shop]
  before_filter :authenticate_shop!, only: [:new, :edit, :update, :delete, :logged_shop]
  before_filter :signed_in, only: [:index, :show]

  # GET /shops/1/coupons
  # GET /shops/1/coupons.json
  def index
    @coupons = Coupon.where('shop_id = ?', params[:shop_id])

    respond_to do |format|
      format.html { show_from_resource('index', 'shop_index') }
      format.json { render json: @coupons }
    end
  end

  # GET /shops/1/coupons/1
  # GET /shops/1/coupons/1.json
  def show
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      format.html { show_from_resource('show', 'shop_show')}
      format.json { render json: @coupon }
    end
  end

  # GET /shops/1/coupons/new
  # GET /shops/1/coupons/new.json
  def new
    @coupon = Coupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /shops/1/coupons/1/edit
  def edit
    @coupon = Coupon.find(params[:id])
  end

  # POST /shops/1/coupons
  # POST /shops/1/coupons.json
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

  # PUT /shops/1/coupons/1
  # PUT /shops/1/coupons/1.json
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

  # DELETE /shops/1/coupons/1
  # DELETE /shops/1/coupons/1.json
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end

  # GET /
  def top
    @coupons = Coupon.order('created_at DESC').limit(20)
    
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: [@new_coupons, @recommended_coupons] }
    end
  end

  # GET /shops/1/coupons/show_new
  def show_new
    @new_coupons = Coupon.all

    respond_to do |format|
      format.html # show_new.html.erb
      format.json { render json: @new_coupons }
    end
  end

  # POST /shops/1/coupons/1/share
  def share
    respond_to do |format|
      format.html # share.html.erb
    end
  end

  # GET /coupons/ranking
  def ranking
    @coupons = Coupon.all

    respond_to do |format|
      format.html
      format.json { render json: @coupons }
    end
  end

  # POST /shops/1/coupons/1/use
  def use
    coupon = Coupon.find(params[:id])
    user = current_user
    if not user.has?(coupon)
      user.coupon_usages.build(coupon_id: coupon.id)
    end
    if user.coupons.use(coupon)
      redirect_to root_path # TODO redirect to page to show coupon
    else
      redirect_to [coupon.shop, coupon], notice: 'You cannot use this coupon anymore.'
    end
  end

  private
  def logged_shop
    @coupons = Coupon.where('shop_id = ?', current_shop.id)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @coupons }
    end
  end
end

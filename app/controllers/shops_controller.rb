class ShopsController < ApplicationController
  before_filter :authenticate_user!, only: [:my, :add_to_my, :remove_from_my]
  before_filter :authenticate_shop!, only: [:edit, :update, :destroy]
  before_filter :signed_in!, only: [:show]
  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @shop = Shop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/new
  # GET /shops/new.json
  def new
    @shop = Shop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(params[:shop])

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html { render action: "new" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shops/1
  # PUT /shops/1.json
  def update
    @shop = Shop.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end

  # GET shops/my
  def my
    @shops = current_user.shops
    respond_to do |format|
      format.html { render template: 'shops/my_shops'}
      format.json { render json: @shops }
    end
  end

  # GET /shops/search
  def search
    @shop = Shop.new
    respond_to do |format|
      format.html # search.html.erb
      format.json { head :no_content }
    end
  end

  # GET /shops/find
  def find
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  # POST /shops/1/add_to_my
  def add_to_my
    shop = Shop.find(params[:id])
    unless shop.nil? || current_user.shops.include?(shop)
      current_user.shops << shop
    end
    render json: {}
  end

  # POST /shops/1/remove_from_my
  def remove_from_my
    shop = Shop.find(params[:id])
    unless shop.nil? || !current_user.shops.include?(shop)
      current_user.shops.delete(shop)
      current_user.save
    end
    render json: {}
  end
end

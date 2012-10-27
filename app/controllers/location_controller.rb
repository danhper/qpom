class LocationController < ApplicationController
    def prefectures
        @prefectures = Prefecture.where("area_id = ?", params[:area_id])
        render json: @prefectures
    end

    def towns
        @towns = Town.where("prefecture_id = ?", params[:prefecture_id])
        render json: @towns
    end
end
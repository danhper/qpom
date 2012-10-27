class LocationController < ApplicationController
    def prefectures
        @prefectures = Prefecture.where("area_id = ?", params[:id])
        render json: @prefectures
    end

    def towns
        @towns = Town.where("prefecture_id = ?", params[:id])
        render json: @towns
    end
end
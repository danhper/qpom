class ApplicationController < ActionController::Base
    protect_from_forgery

    def after_sign_in_path_for(resource)
        resource.is_a?(User) ? root_path : shop_coupons_path(resource)
    end

    def after_sign_out_path_for(resource)
        resource.is_a?(User) ? new_user_session_path : new_shop_session_path
    end

    def signed_in
        redirect_to new_user_session unless user_signed_in? || shop_signed_in?
    end

    def is_current_shop(shop)
        if shop_signed_in?
            redirect_to shop_coupons_path(shop) unless shop == current_shop
        else
            redirect_to new_shop_session
        end
    end


    def upload_file(coupon)
        image_id = SecureRandom.urlsafe_base64
        Cloudinary::Uploader.upload(coupon.image_file, public_id: image_id)
        coupon.image = image_id + File.extname(coupon.image_file.original_filename)
    end

end

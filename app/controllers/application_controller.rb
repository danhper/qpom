class ApplicationController < ActionController::Base
    protect_from_forgery

    def after_sign_in_path_for(resource)
        resource.is_a?(User) ? root_path : new_shop_coupon_path(resource)
    end

    def signed_in
        redirect_to new_user_session unless user_signed_in? or shop_signed_in?
    end

    def upload_file(coupon)
        image_id = SecureRandom.urlsafe_base64
        Cloudinary::Uploader.upload(coupon.image_file, public_id: image_id)
        coupon.image = image_id + File.extname(coupon.image_file.original_filename)
    end

end

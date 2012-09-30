module CouponsHelper
    def validity_time(coupon)
        start_date, end_date = coupon.validity_start_datetime, coupon.validity_end_datetime
        start_str, end_str = I18n.l(start_date, format: "ymd"), I18n.l(end_date, format: "ymd")
        if start_date < Date.today
            I18n.t :valid_from_to, start: start_str, stop: end_str
        else
            I18n.t :valid_until, date: end_str
        end
    end
end

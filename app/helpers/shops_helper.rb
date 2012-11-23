module ShopsHelper
    def format_address(shop)
        "#{shop.prefecture.name}#{shop.town.name}#{shop.address}"
    end
end

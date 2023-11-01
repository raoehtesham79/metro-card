class TripSummary
    def self.get_summary(card_info, age_group)
      total_fare, discount = card_info.get_trip_fare(age_group)
      total_fare = card_info.set_wallet_balance(total_fare)
      [total_fare, discount, card_info]
    end
end
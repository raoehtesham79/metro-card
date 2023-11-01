class Card
    attr_accessor :balance, :single_trip_status
  
    def initialize(card_id, balance)
      @card_id = card_id
      @balance = balance
      @single_trip_status = false
    end
  
    def get_trip_fare(age_grp)
      fare_tab = { 'ADULT' => 200.0, 'SENIOR_CITIZEN' => 100.0, 'KID' => 50.0 }
      discount = total_fare = 0.0
  
      total_fare = self.single_trip_status ? 0.5 * fare_tab[age_grp] : fare_tab[age_grp]
      discount = self.single_trip_status ? total_fare : 0.0
  
      [total_fare, discount]
    end
  
    def set_wallet_balance(total_fare)
      tax = 0.02
      new_balance = self.balance - total_fare

      if new_balance < 0
        total_fare += (-tax * new_balance).abs
        new_balance = 0.0
      end
  
      self.balance = new_balance
      self.single_trip_status = !self.single_trip_status
      total_fare
    end

    def self.manage(card_id, recharge_amount, card_storage)
      if card_storage.key?(card_id)
        card_storage[card_id].balance += recharge_amount.to_i
      else
        card_storage[card_id] = Card.new(card_id, recharge_amount.to_i)
      end
      card_storage
    end
end

  
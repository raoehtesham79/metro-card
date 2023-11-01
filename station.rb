class Station
    def initialize(station)
      @station = station
      @passenger_age_cnt = { 'ADULT' => 0, 'SENIOR_CITIZEN' => 0, 'KID' => 0 }
      @total_sale = 0.0
      @total_discount = 0.0
    end
  
    def get_station_summary
      puts "TOTAL_COLLECTION #{@station} #{total_sale.to_i} #{total_discount.to_i}"
      puts "PASSENGER_TYPE_SUMMARY"
      sorted_passenger_counts = passenger_age_cnt.sort_by { |k, v| [-v, k] }
      sorted_passenger_counts.each do |passenger_type, count|
        if count > 0
          puts "#{passenger_type} #{count}"
        end
      end
    end
  
    def put_traveller_entry(passenger_age_grp, fare, discount)
      passenger_age_cnt[passenger_age_grp] += 1
      self.total_sale += fare
      self.total_discount += discount
    end
  
    private
  
    attr_accessor :passenger_age_cnt, :total_sale, :total_discount
end
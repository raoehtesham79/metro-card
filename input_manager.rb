require_relative 'station.rb'
require_relative 'card.rb'
require_relative 'trip_summary.rb'
  
class InputManager
    def self.manage(lines)
      stations_storage = { 'CENTRAL' => Station.new('CENTRAL'), 'AIRPORT' => Station.new('AIRPORT') }
      card_storage = {}
  
      lines.each do |line|
        ip_line = line.strip.split(' ')
  
        case ip_line[0]
        when 'BALANCE'
          card_storage = Card.manage(ip_line[1], ip_line[2].to_i, card_storage)
  
        when 'CHECK_IN'
          raise 'User not found' unless card_storage.key?(ip_line[1])
  
          total_fare, discount, card_storage[ip_line[1]] = TripSummary.get_summary(card_storage[ip_line[1]], ip_line[2])
          stations_storage[ip_line[3]].put_traveller_entry(ip_line[2], total_fare, discount)
  
        when 'PRINT_SUMMARY'
          stations_storage.each do |station, data|
            data.get_station_summary
          end
        end
      end
    end
end
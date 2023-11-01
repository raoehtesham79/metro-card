require 'spec_helper'
require './station.rb'

RSpec.describe Station do
  let(:station_name) { 'CENTRAL' }
  let(:station) { described_class.new(station_name) }

  describe '#initialize' do
    it 'creates a Station object with the given attributes' do
      expect(station.instance_variable_get(:@station)).to eq(station_name)
      expect(station.instance_variable_get(:@passenger_age_cnt)).to eq('ADULT' => 0, 'SENIOR_CITIZEN' => 0, 'KID' => 0)
      expect(station.instance_variable_get(:@total_sale)).to eq(0.0)
      expect(station.instance_variable_get(:@total_discount)).to eq(0.0)
    end
  end

  describe '#get_station_summary' do
    it 'prints the correct station summary' do
      station.instance_variable_set(:@total_sale, 250.0)
      station.instance_variable_set(:@total_discount, 30.0)
      station.instance_variable_set(:@passenger_age_cnt, 'ADULT' => 2, 'SENIOR_CITIZEN' => 1, 'KID' => 0)

      expected_output = <<~OUTPUT
        TOTAL_COLLECTION CENTRAL 250 30
        PASSENGER_TYPE_SUMMARY
        ADULT 2
        SENIOR_CITIZEN 1
      OUTPUT

      expect { station.get_station_summary }.to output(expected_output).to_stdout
    end
  end

  describe '#put_traveller_entry' do
    it 'updates passenger counts, total sale, and total discount' do
      station.put_traveller_entry('ADULT', 200.0, 0.0)
      station.put_traveller_entry('KID', 50.0, 0.0)

      expect(station.instance_variable_get(:@passenger_age_cnt)['ADULT']).to eq(1)
      expect(station.instance_variable_get(:@passenger_age_cnt)['KID']).to eq(1)
      expect(station.instance_variable_get(:@total_sale)).to eq(250.0)
      expect(station.instance_variable_get(:@total_discount)).to eq(0.0)
    end
  end
end

require 'spec_helper'
require './trip_summary.rb'
require './card.rb'

RSpec.describe TripSummary do
  describe '.get_summary' do
    let(:card_id) { '1234' }
    let(:initial_balance) { 100.0 }
    let(:card) { Card.new(card_id, initial_balance) }
    
    it 'returns the correct summary for an adult trip' do
      allow(card).to receive(:get_trip_fare).with('ADULT').and_return([200.0, 0.0])
      allow(card).to receive(:set_wallet_balance).with(200.0).and_return(150.0)

      total_fare, discount, updated_card = described_class.get_summary(card, 'ADULT')

      expect(total_fare).to eq(150.0)
      expect(discount).to eq(0.0)
      expect(updated_card).to eq(card)
    end

    it 'returns the correct summary for a senior citizen trip' do
      allow(card).to receive(:get_trip_fare).with('SENIOR_CITIZEN').and_return([100.0, 0.0])
      allow(card).to receive(:set_wallet_balance).with(100.0).and_return(50.0)

      total_fare, discount, updated_card = described_class.get_summary(card, 'SENIOR_CITIZEN')

      expect(total_fare).to eq(50.0)
      expect(discount).to eq(0.0)
      expect(updated_card).to eq(card)
    end

    it 'returns the correct summary for a kid trip' do
      allow(card).to receive(:get_trip_fare).with('KID').and_return([50.0, 0.0])
      allow(card).to receive(:set_wallet_balance).with(50.0).and_return(0.0)

      total_fare, discount, updated_card = described_class.get_summary(card, 'KID')

      expect(total_fare).to eq(0.0)
      expect(discount).to eq(0.0)
      expect(updated_card).to eq(card)
    end
  end
end

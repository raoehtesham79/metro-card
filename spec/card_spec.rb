require 'spec_helper'
require './card.rb'

RSpec.describe Card do
  let(:initial_balance) { 100.0 }
  let(:card_id) { '1234' }
  let(:card) { Card.new(card_id, initial_balance) }

  describe '#initialize' do
    it 'creates a Card object with the given attributes' do
      expect(card.balance).to eq(initial_balance)
      expect(card.single_trip_status).to be_falsey
    end
  end

  describe '#get_trip_fare' do
    it 'returns the correct fare and discount for an adult' do
      fare, discount = card.get_trip_fare('ADULT')
      expect(fare).to eq(200.0)
      expect(discount).to eq(0.0)
    end

    it 'returns the correct fare and discount for a senior citizen' do
      fare, discount = card.get_trip_fare('SENIOR_CITIZEN')
      expect(fare).to eq(100.0)
      expect(discount).to eq(0.0)
    end

    it 'returns the correct fare and discount for a kid' do
      fare, discount = card.get_trip_fare('KID')
      expect(fare).to eq(50.0)
      expect(discount).to eq(0.0)
    end
  end

  describe '#set_wallet_balance' do
    it 'deducts the total fare and updates the balance and trip status' do
      fare, _ = card.get_trip_fare('ADULT')
      new_balance = card.set_wallet_balance(fare)
      expect(new_balance).to eq(202.0)
    end
  end

  describe '.manage' do
    let(:recharge_amount) { 50 }

    it 'recharges an existing card' do
      card_storage = { card_id => card }
      updated_card_storage = Card.manage(card_id, recharge_amount, card_storage)
      expect(updated_card_storage[card_id].balance).to eq(initial_balance + recharge_amount)
    end

    it 'creates a new card if it does not exist in the storage' do
      card_storage = {}
      updated_card_storage = Card.manage(card_id, recharge_amount, card_storage)
      expect(updated_card_storage[card_id].balance).to eq(recharge_amount)
    end
  end
end

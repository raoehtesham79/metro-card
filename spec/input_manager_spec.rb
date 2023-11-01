require 'spec_helper'
require './station.rb'
require './trip_summary.rb'
require './input_manager.rb'
require './card.rb'

RSpec.describe InputManager do
    let(:stations_storage) do
      {
        'CENTRAL' => Station.new('CENTRAL'),
        'AIRPORT' => Station.new('AIRPORT')
      }
    end
  
    let(:card_storage) { {} }
  
    describe '.manage' do
      it 'handles BALANCE command' do
        lines = ['BALANCE Alice 50']
        card_storage['Alice'] = Card.new('Alice', 50)
        InputManager.manage(lines)
        expect(card_storage['Alice'].balance).to eq(50) 
      end
    end
  end
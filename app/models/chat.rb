# frozen_string_literal: true

class Chat < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :messages

  aasm column: 'state' do
    state :greetings, initial: true
    state :menu
    state :check_deposit
    state :paper_rolls_request
    state :consult_economic_indicators
    state :utm
    state :uf
    state :cpt
    state :deposits

    event :greetings do
      transitions from: :menu, to: :greetings
    end

    event :check_deposit do
      transitions from: :menu, to: :check_deposit
    end

    event :paper_rolls_request do
      transitions from: :menu, to: :paper_rolls_request
    end

    event :consult_economic_indicators do
      transitions from: :menu, to: :consult_economic_indicators
    end

    event :utm do
      transitions from: :consult_economic_indicators, to: :utm
    end

    event :uf do
      transitions from: :consult_economic_indicators, to: :uf
    end

    event :cpt do
      transitions from: :consult_economic_indicators, to: :cpt
    end

    event :menu do
      transitions from: %i[greetings check_deposit paper_rolls_request
                           consult_economic_indicators utm uf cpt], to: :menu
    end
  end
end

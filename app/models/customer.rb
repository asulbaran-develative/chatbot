# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :deposits
  has_many :invoices
end

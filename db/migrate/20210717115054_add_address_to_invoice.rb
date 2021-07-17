# frozen_string_literal: true

# Esto es temporal
class AddAddressToInvoice < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :delivery_address, :string
  end
end

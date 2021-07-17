# frozen_string_literal: true

# Generar modelo de Facturas
class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :delivery_address
      t.integer :quantity
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end

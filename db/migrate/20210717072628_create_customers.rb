# frozen_string_literal: true

# Generar modelo clientes
class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :rut
      t.string :name
      t.string :last_name
      t.string :address
      t.string :phone
      t.float :balance
      t.string :state

      t.timestamps
    end
  end
end

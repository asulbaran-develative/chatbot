# frozen_string_literal: true

# Generar modelo Depositos
class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :description
      t.float :amount
      t.datetime :date_of_process
      t.string :state

      t.timestamps
    end
  end
end

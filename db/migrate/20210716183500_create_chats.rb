# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.string :state, default: 'greetings'

      t.timestamps
    end
  end
end

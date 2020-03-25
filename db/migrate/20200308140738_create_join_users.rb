# frozen_string_literal: true

class CreateJoinUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :join_users do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

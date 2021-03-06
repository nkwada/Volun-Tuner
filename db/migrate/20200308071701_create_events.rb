# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.datetime :start_time
      t.integer :prefecture
      t.string :address
      t.string :image
      t.float :latitude
      t.float :longitude
      t.references :user, index: true
      t.timestamps
    end
  end
end

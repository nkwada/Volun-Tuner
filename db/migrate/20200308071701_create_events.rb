class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|

	  t.string :title
	  t.text :content
	  t.date :date
	  t.string :time
	  t.string :postal_code
	  t.string :address
	  t.string :area
	  t.references :user, index: true
      t.timestamps
    end
  end
end

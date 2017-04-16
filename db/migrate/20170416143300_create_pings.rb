class CreatePings < ActiveRecord::Migration[5.0]
  def up
  	create_table :pings do |t|
  		t.string :device_ID
      t.integer :time
  	end
  end

  def down
  	drop_table :pings
  end
end

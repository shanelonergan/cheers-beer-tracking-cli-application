class CreateConsumerBeers < ActiveRecord::Migration[5.0]
  def change
    create_table :consumer_beers do |t|
      t.integer :beer_id
      t.integer :consumer_id
      t.integer :num_consumed, default: 0
      t.integer :num_available
      t.float :size
      t.string :packaging
      t.date :exp_date
      t.float :rating, default: nil
    end
  end
end

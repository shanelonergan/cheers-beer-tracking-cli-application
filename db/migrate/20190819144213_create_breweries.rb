class CreateBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :location
      t.string :specialty
      t.integer :year_founded
    end
  end
end

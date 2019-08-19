class CreateBeers < ActiveRecord::Migration[5.0]
  def change
    create_table :beers do |t|
      t.integer :brewery_id
      t.string :name
      t.string :style
      t.string :additions
      t.float :abv
    end
  end
end

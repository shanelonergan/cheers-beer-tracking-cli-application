class CreateConsumers < ActiveRecord::Migration[5.0]
  def change
    create_table :consumers do |t|
      t.string :name
      t.integer :age
      t.string :location
      t.string :gender
      t.string :favorite_style
    end
  end
end

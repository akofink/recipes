class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name
      t.string :path
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end

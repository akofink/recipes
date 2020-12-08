class RemoveFieldsFromImage < ActiveRecord::Migration[5.0]
  def change
    rename_column :images, :name, :data
    remove_column :images, :path
  end
end

class RemoveFieldsFromImage < ActiveRecord::Migration
  def change
    rename_column :images, :name, :data
    remove_column :images, :path
  end
end

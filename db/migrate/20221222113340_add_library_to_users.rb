class AddLibraryToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :library, :integer, array: true, default: []
  end
end

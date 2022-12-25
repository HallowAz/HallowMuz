class DeleteUserIdFromSingers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :singers, :user
  end
end

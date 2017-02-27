class ChangeForUsers < ActiveRecord::Migration[5.0]
  def change
      rename_column :users, :passwor, :password_digest
  end
end

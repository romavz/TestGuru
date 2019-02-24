class ChangeTableUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.column :password_digest, :string
      t.remove_index :nick_name
      t.index :email
    end
  end
end

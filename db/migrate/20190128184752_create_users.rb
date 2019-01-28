class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nick_name

      t.timestamps
    end
    add_index :users, :nick_name, unique: true
  end
end

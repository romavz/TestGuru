class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :image_path, null: false
      t.string :rule_name, null: false
      t.string :rule_value
      t.boolean :multiple, null: false, default: false

      t.timestamps
    end
    add_index :badges, :title, unique: true
  end
end

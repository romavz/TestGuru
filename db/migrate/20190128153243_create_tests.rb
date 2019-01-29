class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title
      t.integer :level
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :tests, :title, unique: true

    change_column_default(:tests, :level, from: nil, to: 0)
    change_column_null(:tests, :level, false)
    change_column_null(:tests, :title, false)
    change_column_null(:tests, :category_id, false)
  end
end

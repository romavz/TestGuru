class RemoveMultipleColumnFromBadges < ActiveRecord::Migration[5.2]
  def up
    remove_column :badges, :multiple
  end

  def down
    add_column :badges, :multiple, :boolean, default: false, null: false
  end
end

class ChangeTableBadge < ActiveRecord::Migration[5.2]
  def up
    remove_column :badges, :multiple
    add_index :badges, %i[rule_name rule_value], unique: true, name: 'badge_rewarding_rules'
  end

  def down
    remove_index :badges, name: 'badge_rewarding_rules'
    add_column :badges, :multiple, :boolean, default: false, null: false
  end
end

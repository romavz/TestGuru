class AddPassedToTestPassages < ActiveRecord::Migration[5.2]
  def up
    add_column :test_passages, :passed, :boolean, default: false, null: false
    TestPassage.all.each(&:update_passed_state)
  end

  def down
    remove_column :test_passages, :passed
  end
end

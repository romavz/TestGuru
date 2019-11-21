class AddCompleteStatusToTestPassages < ActiveRecord::Migration[5.2]
  def up
    add_column :test_passages, :complete_status, :integer
    TestPassage.all.each(&:update_complete_status)
  end

  def down
    remove_column :test_passages, complete_status
  end
end

class ChangeTitleIndexOnTest < ActiveRecord::Migration[5.2]
  def change
    remove_index  :tests, column: :title
    add_index     :tests, [:title, :level], unique: true
  end
end

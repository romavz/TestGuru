class AddTimeLimitToTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :time_limit, :integer, null: false, default: 5
    add_column :tests, :time_scale, :string, null: false, default: "minutes"
  end
end

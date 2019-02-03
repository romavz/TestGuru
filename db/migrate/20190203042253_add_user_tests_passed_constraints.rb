class AddUserTestsPassedConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:user_tests, :passed, from: nil, to: false)
    change_column_null(:user_tests, :passed, false)
  end
end

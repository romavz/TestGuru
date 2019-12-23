class CreateIssuedBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :issued_badges do |t|
      t.references :user, foreign_key: true, null: false
      t.references :badge, foreign_key: true, null: false

      t.timestamps
    end
  end
end

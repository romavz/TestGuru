class ChangeTableIssuedBadges < ActiveRecord::Migration[5.2]
  def up
    drop_table :issued_badges

    create_table :issued_badges do |t|
      t.references :test_passage, foreign_key: true, null: false
      t.references :badge, foreign_key: true, null: false

      t.timestamps
    end
  end

  def down
    drop_table :issued_badges

    create_table :issued_badges do |t|
      t.references :user, foreign_key: true, null: false
      t.references :badge, foreign_key: true, null: false

      t.timestamps
    end
  end
end

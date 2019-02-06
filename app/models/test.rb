class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, {
    class_name: "User",
    foreign_key: "user_id",
    inverse_of: :owned_tests
  }

  has_many :questions, dependent: :destroy
  has_many :user_tests, dependent: :destroy
  has_many :users, through: :user_tests, dependent: :destroy

  def self.take_titles_by_category(title)
    self.joins("
      INNER JOIN categories
        ON tests.category_id = categories.id
    ").
    where(
      categories: { title: title }
    ).
    order(title: :desc).
    pluck(:title)
  end

end

class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  has_many :user_tests
  has_many :users, through :user_tests

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

class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "author_id", inverse_of: :owned_tests

  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages, dependent: :destroy

  scope :easy,    -> { where(level: [0..1]) }
  scope :medium,  -> { where(level: [2..4]) }
  scope :hard,    -> { where(level: [5..Float::INFINITY]) }

  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level }

  scope :select_by_category_title, ->(title) {
    joins(:category)
      .where(categories: { title: title })
      .order(title: :desc)
  }

  scope :select_by_category,  ->(category) { joins(:category).where(categories: { id: category.id }) }
  scope :select_by_level,     ->(level) { where(level: level) }

  def user_test_passages(user)
    test_passages.where(user: user)
  end

  def self.take_titles_by_category(title)
    select_by_category_title(title).pluck(:title)
  end
end

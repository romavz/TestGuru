class Category < ApplicationRecord
  default_scope { order(title: :asc) }

  has_many :tests, dependent: :nullify
  has_many :test_passages, through: :tests

  validates :title, presence: true

end

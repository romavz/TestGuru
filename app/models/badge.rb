class Badge < ApplicationRecord
  REWARDING_RULES = %i[first_test_passed test_passed_by_one_try category_complete level_complete].freeze

  has_many :issued_badges, dependent: :destroy
  has_many :user, through: :issued_badges, dependent: :destroy

  validates :title, presence: true
end

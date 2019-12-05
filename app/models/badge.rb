class Badge < ApplicationRecord
  REWARDING_RULES = %i[first_test_passed test_passed_by_one_try category_complete level_complete].freeze

  has_many :issued_badges, dependent: :destroy
  has_many :user, through: :issued_badges, dependent: :destroy

  validates :title, :rule_name, presence: true
  validate :image_path_must_locate_to_existing_file

  def image_path_must_locate_to_existing_file
    Validators::ImageExistenceValidator.run!(image_path)
  rescue AppExceptions::BaseException => error
    errors.add :image_path, error.message
  end
end

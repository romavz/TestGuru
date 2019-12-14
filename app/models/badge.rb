class Badge < ApplicationRecord
  has_many :issued_badges, dependent: :destroy
  has_many :user, through: :issued_badges, dependent: :destroy

  validates :title, :rule_name, presence: true
  validate  :image_path_must_locate_to_existing_file
  validate  :rule_and_value_combination_must_be_unique
  validates :rule_name, inclusion: { in: BadgeIssuingService.rewarding_rules.map(&:to_s) }

  def image_path_must_locate_to_existing_file
    Validators::ImageExistenceValidator.validate!(image_path)
  rescue AppExceptions::FileNotFoundException
    errors.add :image_path, :file_not_found
  end

  def rule_and_value_combination_must_be_unique
    badge = Badge.find_by(rule_name: rule_name, rule_value: rule_value)
    return if badge.nil?

    errors.add :base, :rule_and_value_combination_already_in_use
  end

end

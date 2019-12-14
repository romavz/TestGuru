class Badge < ApplicationRecord
  has_many :issued_badges, dependent: :destroy
  has_many :user, through: :issued_badges, dependent: :destroy

  validates :title, :rule_name, presence: true
  validate :image_path_must_locate_to_existing_file
  validates :rule_name, inclusion: { in: BadgeIssuingService.rewarding_rules }

  def image_path_must_locate_to_existing_file
    Validators::ImageExistenceValidator.validate!(image_path)
  rescue AppExceptions::FileNotFoundException
    errors.add :image_path, :file_not_found
  end

end

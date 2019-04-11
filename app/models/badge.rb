class Badge < ApplicationRecord
  has_many :issuer_badges, dependent: :destroy
  has_many :user, through: :issued_badges, dependent: :destroy

  validates :title, presence: true
end

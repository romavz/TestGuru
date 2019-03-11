class Gist < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :url, :user, :question, presence: true
end

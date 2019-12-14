class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy

  validates :body, presence: true

  def self.next_question(current_question_id)
    where('id > ?', current_question_id).first
  end
end

class Answer < ApplicationRecord
  MAX_ANSWERS_BY_QUESTION = 4.freeze
  ANSWER_LIMIT_ERROR_MESSAGE = "Лимит ответов на один вопрос: #{MAX_ANSWERS_BY_QUESTION}".freeze

  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_limit_for_question, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_limit_for_question
    errors.add(:base, ANSWER_LIMIT_ERROR_MESSAGE) if question.answers.count >= 4
  end

end

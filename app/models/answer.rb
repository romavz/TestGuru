class Answer < ApplicationRecord
  MAX_ANSWERS_BY_QUESTION = 4
  ANSWER_LIMIT_ERROR_MESSAGE = "Лимит ответов на один вопрос: #{MAX_ANSWERS_BY_QUESTION}".freeze

  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_limit_for_question, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_limit_for_question
    return if question.answers.count < MAX_ANSWERS_BY_QUESTION

    errors.add(:base, ANSWER_LIMIT_ERROR_MESSAGE)
  end

end

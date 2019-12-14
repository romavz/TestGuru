class TestPassage < ApplicationRecord
  P100 = 100
  SUCCESS_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: "Question", optional: true

  before_validation :load_first_question, on: [:create]

  scope :passed, -> { where(passed: true) }

  def progress
    "#{current_question_number}/#{questions_count}"
  end

  def current_question_number
    if completed?
      questions_count
    else
      questions.where('id < ?', current_question.id).size + 1
    end
  end

  def questions_count
    @questions_count ||= test.questions.count
  end

  def question_text
    current_question.body
  end

  def current_answers
    current_question.answers
  end

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    step_to_next_question
    update_passed_state
    save!
  end

  def update_passed_state
    update!(passed: correct_questions_ratio >= SUCCESS_PERCENT)
  end

  def correct_questions_ratio
    (correct_questions.to_f * P100 / test.questions.count).round(1)
  end

  private

  def questions
    @questions ||= test.questions.order(:id)
  end

  def load_first_question
    self.current_question = questions.first
  end

  def step_to_next_question
    return if completed?

    self.current_question = questions.next_question(current_question.id)
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

end

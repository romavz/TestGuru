class TestPassage < ApplicationRecord
  P100 = 100
  SUCCESS_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: "Question", optional: true

  enum complete_status: { failed: 0, successfull: 1 }

  before_validation :set_current_question

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
    update_complete_status
    save!
  end

  def update_complete_status
    update(complete_status: correct_questions_ratio >= SUCCESS_PERCENT ? :successfull : :failed) if completed?
  end

  def correct_questions_ratio
    (correct_questions.to_f * P100 / test.questions.count).round(1)
  end

  private

  def questions
    test.questions.order(:id)
  end

  def set_current_question
    self.current_question = next_question unless completed?
  end

  def next_question
    if new_record?
      questions.first
    else
      questions.where('id > ?', current_question.id).first
    end
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

end

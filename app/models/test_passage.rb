class TestPassage < ApplicationRecord
  P100 = 100
  SUCCESS_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: "Question", optional: true
  has_many :issued_badges, dependent: :destroy
  has_many :badges, through: :issued_badges

  before_validation :load_first_question, on: [:create]

  scope :passed, -> { where(passed: true) }
  scope :select_by_category, ->(category) { joins(:test).where(tests: { category: category }) }
  scope :select_by_level, ->(level) { joins(:test).where(tests: { level: level }) }

  scope :after_date, ->(date) {
    where("test_passages.created_at > ?", date)
  }

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
    current_question.nil? || time_over?
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

  def ending_time
    created_at + time_limit
  end

  def time_limit
    test.time_limit.send(test.time_scale)
  end

  def available_time_in_seconds
    return 0 if completed?

    (created_at + time_limit - Time.now).to_i
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

  # def update_elapsed_time
  #   return if time_over?

  #   self.elapsed_time = Time.now - created_at
  # end

  def time_over?
    Time.now - created_at >= time_limit
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

end

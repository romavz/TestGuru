module TestPassagesHelper
  STYLE = { true => 'test_success', false => 'test_fail' }.freeze
  CONCLUSION = {
    true  => 'Test completed successfull',
    false => 'Test fail'
  }.freeze

  def style (test_result_state)
    STYLE[test_result_state]
  end

  def test_result(test_passage)
    "#{test_passage.test.title}
    #{CONCLUSION[test_passage.completed_successfull?]} (#{test_passage.correct_questions_ratio}%)"
  end

  def test_progress(test_passage)
    "(#{test_passage.current_question_number}/#{test_passage.test.questions.count})"
  end

end

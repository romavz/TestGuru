module TestPassagesHelper
  CONCLUSION = {
    true  => 'Test completed successfull',
    false => 'Test fail'
  }.freeze

  def test_conclusion(test_passage)
    "#{CONCLUSION[test_passage.successfull?]} (#{test_passage.correct_questions_ratio}%)"
  end

end

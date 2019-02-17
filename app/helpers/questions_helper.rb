module QuestionsHelper
def question_header (test, question)
  prefix = question.new_record? ? "Create New" : "Edit"
  "#{prefix} <#{test.title}> Question."
end

end

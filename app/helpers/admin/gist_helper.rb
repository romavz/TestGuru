module Admin::GistHelper
  def short_question(question)
    question.body[0..25]
  end

  def gist_id(url)
    url.split("/").last
  end
end
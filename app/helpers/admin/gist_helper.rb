module Admin::GistHelper
  def short_question(question)
    truncate(question.body, length: 25, separator: ' ')
  end

  def gist_id(url)
    url.split("/").last
  end
end

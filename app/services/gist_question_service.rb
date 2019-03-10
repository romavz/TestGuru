class GistQuestionService
  QueryResult = Struct.new(:html_url) do
    def success?
      html_url.present?
    end
  end

  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    response = @client.create_gist(gist_params)
    QueryResult.new(response.html_url)
  end

  private

  def gist_params
    description = 'gist_question_service.gist_description'
    {
      description: I18n.translate(description, test_title: @test.title),
      files: {
        'test-guru-question.txt': {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

  def default_client
    Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

end

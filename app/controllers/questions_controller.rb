class QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  before_action :fill_test_info, only: %i[index new create]
  before_action :fill_question_info, only: %i[show edit update destroy]

  def index
    @test_title = @test.title
    @questions = @test.questions

  end

  def show
    @test_title = @question.test.title
    @answers = @question.answers
    @question_text = @question.body
  end

  def new

  end

  def create
    question_body = params[:question][:body]
    redirect_to test_questions_path if question_body.empty?

    Question.create( test: @test, body: question_body )
    redirect_to test_questions_path

  end

  def edit

  end

  def update

  end

  def destroy
    test_id = @question.test_id
    return_url = test_questions_path(test_id)

    @question.destroy

    redirect_to return_url
  end

  private

  def fill_test_info
    test_id = params[:test_id].to_i
    @test = Test.find(test_id)
  end

  def fill_question_info
    question_id = params[:id].to_i
    @question = Question.find(question_id)
  end

  def rescue_with_record_not_found
    render plain: 'Запись не найдена'
  end

end

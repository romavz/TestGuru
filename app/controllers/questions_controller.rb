class QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  before_action :load_test, only: %i[index new create]
  before_action :load_question, only: %i[show edit update destroy]

  def index; end
  def show; end
  def new; end

  def create
    question_body = params[:question][:body]
    redirect_to test_questions_path if question_body.empty?

    Question.create( test: @test, body: question_body )
    redirect_to test_questions_path
  end

  def edit; end
  def update; end

  def destroy
    @question.destroy
    redirect_to test_questions_path(@question.test_id)
  end

  private

  def load_test
    @test = Test.find(params[:test_id])
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def rescue_with_record_not_found
    render plain: 'Запись не найдена'
  end

end

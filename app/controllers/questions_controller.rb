class QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  before_action :load_test, only: %i[index new create]
  before_action :load_question, only: %i[show edit update destroy]

  def index
    redirect_to test_path(@test)
  end

  def show
    @test = @question.test
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to test_path(@test)
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy
    @question.destroy
    redirect_to test_path(@question.test)
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

  def question_params
    params.require(:question).permit(:test_id, :body)
  end

end

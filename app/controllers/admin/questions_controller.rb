class Admin::QuestionsController < Admin::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  before_action :load_test, only: %i[new create]
  before_action :load_question, only: %i[show edit update destroy]

  def show
    @test = @question.test
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to [:admin, @question]
    else
      render :new
    end
  end

  def edit
    @test = @question.test
  end

  def update
    if @question.update(question_params)
      redirect_to [:admin, @question]
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to [:admin, @question.test]
  end

  private

  def load_test
    @test = Test.find(params[:test_id])
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def rescue_with_record_not_found
    render plain: t('activerecord.errors.messages.record_not_found')
  end

  def question_params
    params.require(:question).permit(:body)
  end

end

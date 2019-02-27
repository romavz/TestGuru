class Admin::TestsController < Admin::BaseController
  before_action :load_test, only: %i[show edit update destroy]

  def index
    @tests = Test.includes(:category, :author, :questions)
  end

  def show; end

  def new
    @test = Test.new(author: current_user)
  end

  def create
    @test = Test.new(test_params)
    @test.author = current_user
    if @test.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def load_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category, :author)
  end
end

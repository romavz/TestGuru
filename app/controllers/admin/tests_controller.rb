class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i[show edit update destroy]

  def index
    @tests = Test.includes(:category, :author, :questions)
  end

  def show; end

  def new
    @test = Test.new(author: current_user)
  end

  def create
    @test = current_user.owned_tests.new(test_params)
    if @test.save
      redirect_to [:admin, @tests], notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @tests]
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category, :author)
  end
end

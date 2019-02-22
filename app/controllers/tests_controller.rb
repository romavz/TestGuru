class TestsController < ApplicationController
  before_action :load_test, only: %i[start show edit update destroy]
  before_action :set_user,  only: %i[start]

  def index
    @tests = Test.includes(:category, :author, :questions)
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to tests_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def load_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def test_params
    params.require(:test).permit(:title, :level, :category, :author)
  end
end

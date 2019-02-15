class TestsController < ApplicationController
  before_action :load_test, only: %i[show edit update destroy]

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

  def edit
    logger.info "-----------------------"
    logger.info "test: #{@test.attributes.inspect}"
    logger.info "author.name:  #{@test.author.name}"
    logger.info "-----------------------"
  end

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

  private

  def load_test
#    @test = Test.includes(:category, :author)
#            .where(tests: { id: params[:id] })
#            .first

    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category, :author)
  end
end

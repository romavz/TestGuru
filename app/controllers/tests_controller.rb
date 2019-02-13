class TestsController < ApplicationController
  before_action :load_test, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def load_test
    @test = Test.find(params[:test_id])
  end
end

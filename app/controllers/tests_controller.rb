class TestsController < ApplicationController
  before_action :load_test, only: %i[start]

  def index
    @tests = Test.includes(:category, :author, :questions)
  end

  def start
    current_user.tests.push(@test) # TestPassage.create(user: current_user, test: @test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def load_test
    @test = Test.find(params[:id])
  end

end

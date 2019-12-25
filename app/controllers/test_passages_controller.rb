class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show result update gist]

  def show
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    end
  end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      new_badges = BadgeIssuingService.accept(@test_passage)
      current_user.badges << new_badges

      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    question = @test_passage.current_question
    result = GistQuestionService.new(question).call

    if result.success?
      current_user.gists.create!(question_id: question.id, url: result.html_url)
      flash[:notice] = t('.success', link_to: result.html_url)
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = current_user.test_passages.find(params[:id])
  end
end

class SolutionsController < ApplicationController
  
  def create
    @question = Question.find(params[:question_id])
    @solution = @question.solutions.build(solution_params)
    @solution.user = current_user
    @solution.save!
    redirect_to question_path(@question)
  end

  private

  def solution_params
    params.require(:solution).permit(:content)
  end

end

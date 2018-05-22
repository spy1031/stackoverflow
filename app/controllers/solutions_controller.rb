class SolutionsController < ApplicationController
  
  def create
    @question = Question.find(params[:question_id])
    @solution = @question.solutions.build(solution_params)
    @solution.user = current_user
    @solution.save!
    redirect_to question_path(@question)
  end
  
  # 投贊成票
  def upvote
    @solution = Solution.find(params[:id])
    upvotes = Upvote.where(solution: @solution, user: current_user, status: "up")
    if upvotes.exists?
      flash[:alert] = "已投過贊成票"
    else
      flash[:notice] = "投了贊成票"
      @solution.upvotes.create!(user: current_user, status: "up")
      @solution.upvotes_count += 1
      @solution.save
    end
    render :json => {:s_upvotes_count => @solution.upvotes_count}
  end

  # 收回贊成票
  def unupvote
    @solution = Solution.find(params[:id])
    upvotes = Upvote.where(solution: @solution, user: current_user, status: "up")
    upvotes.destroy_all
    flash[:alert] = "取消贊成票"
    @solution.upvotes_count -= 1
    @solution.save
    render :json => {:s_upvotes_count => @solution.upvotes_count}
  end
  
   # 投反對票
  def downvote
    @solution = Solution.find(params[:id])
    upvotes = Upvote.where(solution: @solution, user: current_user, status: "down")
    if upvotes.exists?
      flash[:alert] = "已投過反對票"
    else
      flash[:notice] = "投了反對票"
      @solution.upvotes.create!(user: current_user, status: "down")
      @solution.upvotes_count -= 1
      @solution.save
    end
    render :json => {:s_upvotes_count => @solution.upvotes_count}
  end

  # 收回反對票
  def undownvote
    @solution = Solution.find(params[:id])
    upvotes = Upvote.where(solution: @solution, user: current_user, status: "down")
    upvotes.destroy_all
    flash[:alert] = "取消反對票"
    @solution.upvotes_count += 1
    @solution.save
    render :json => {:s_upvotes_count => @solution.upvotes_count}
  end

  private

  def solution_params
    params.require(:solution).permit(:content)
  end

end

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_question, only: [:show, :favorite, :unfavorite, :upvote, :unupvote, :downvote, :undownvote]

  def index
    @questions = Question.all.page(params[:page]).per(10)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = "問題發布成功"
      redirect_to question_path(@question)
    else
      flash.now[:alert] = "問題發布失敗"
      render :new
    end
  end

  def show
    @solution_by_upvote = @question.solutions.order(upvotes_count: :desc)
    @solution = Solution.new
  end
  
  def favorite
    favorites = Favorite.where(question: @question, user: current_user)
    if favorites.exists?
      flash[:alert] = "已被收藏"
    else
      @question.favorites.create!(user: current_user)
    end
  end

  def unfavorite
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
  end
  
  # 投贊成票
  def upvote
    upvotes = Upvote.where(question: @question, user: current_user, status: "up")
    if upvotes.exists?
      flash[:alert] = "已投過贊成票"
    else
      flash[:notice] = "投了贊成票"
      @question.upvotes.create!(user: current_user, status: "up")
      @question.upvotes_count += 1
      @question.save
    end
    render :json => {:q_upvotes_count => @question.upvotes_count}
  end

  # 收回贊成票
  def unupvote
    upvotes = Upvote.where(question: @question, user: current_user, status: "up")
    upvotes.destroy_all
    flash[:alert] = "取消贊成票"
    @question.upvotes_count -= 1
    @question.save
    
    render :json => {:q_upvotes_count => @question.upvotes_count}
  end
  
  # 投反對票
  def downvote
    upvotes = Upvote.where(question: @question, user: current_user, status: "down")
    if upvotes.exists?
      flash[:alert] = "已投過反對票"
    else
      flash[:notice] = "投了反對票"
      @question.upvotes.create!(user: current_user, status: "down")
      @question.upvotes_count -= 1
      @question.save
    end
    render :json => {:q_upvotes_count => @question.upvotes_count}
  end

  # 收回反對票
  def undownvote
    upvotes = Upvote.where(question: @question, user: current_user, status: "down")
    upvotes.destroy_all
    flash[:alert] = "取消反對票"
    @question.upvotes_count += 1
    @question.save
    
    render :json => {:q_upvotes_count => @question.upvotes_count}
  end
  
  private

  def question_params
    params.require(:question).permit(
      :title,
      :content)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end

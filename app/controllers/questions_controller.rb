class QuestionsController < ApplicationController
  def index
    @questions = Questions.all
  end
end

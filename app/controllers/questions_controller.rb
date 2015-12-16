class QuestionsController < ApplicationController
  def index
      @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order('created_at asc')
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Question is created!"
      redirect_to questions_path
    else
      flash[:notice] = "Invalid input."
      render "new"
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :description, :creator_id)
  end
end

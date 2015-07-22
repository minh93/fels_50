class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :current_lesson, only: [:show]
  before_action :correct_user, except: [:index]

  def index
    @lessons = current_user.lessons
      .paginate page: params[:page], per_page: 10
  end

  def create
    category = Category.find params[:category_id]
    @lesson = category.lessons.build user: current_user
    if @lesson.save
      redirect_to @lesson
    else
      flash[:danger] = t "controllers.lessons.create.flash_danger"
      redirect_to root_path
    end
  end

  def show    
  end

  private
  def current_lesson
    @lesson = Lesson.find params[:id]
  end

  def correct_user
    unless current_user == @lesson.user
      redirect_to root_path
    end
  end
end

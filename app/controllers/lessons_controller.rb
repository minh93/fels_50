class LessonsController < ApplicationController
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
    @lesson = Lesson.find params[:id]
  end
end

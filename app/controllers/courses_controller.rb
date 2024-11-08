class CoursesController < ApplicationController
  def index
    @courses = Course.includes(:teacher).all
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: "Course created successfully."
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to courses_path, notice: "Course updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path, notice: "Course deleted successfully."  # Redirect to index after deletion
  end

  private

  def course_params
    params.require(:course).permit(:name, :teacher_id)
  end
end

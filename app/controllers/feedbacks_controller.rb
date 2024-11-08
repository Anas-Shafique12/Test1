class FeedbacksController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    @feedback = Feedback.new
  end

  def create
    @course = Course.find(params[:course_id])
    @feedback = @course.feedbacks.new(feedback_params)
    if @feedback.save
      redirect_to course_feedbacks_path(@course), notice: "Feedback submitted successfully."
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end

class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Thank you for your comment' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to @comment.commentable, notice: "Failure!" }
        format.json { render json: @comment.commentable, status: :unprocessable_entity }
      end
    end
  end

end
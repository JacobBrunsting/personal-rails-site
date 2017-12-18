class CommentsController < ApplicationController
  def index
      @comments = Comment.all
  end

  def new
      @comment = Comment.new
  end

  def create
      @comment = Comment.new(comment_params)

      if @comment.save
          flash[:success] = 'Added comment!'
      else
          render 'new'
      end
  end

  def show
      @comments = Comment.all
      @comment = Comment.new
  end
end

private

    def comment_params
        params.require(:comment).permit(:author, :email, :text)
    end

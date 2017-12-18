class CommentsController < ApplicationController
  def index
      @comments = ::Comment.all
  end

  def new
      @comment = ::Comment.new
  end

  def create
      @message = '...'
      if comment_params == []
          @message = 'Error Creating Comment'
          return
      end

      @comment = ::Comment.new(comment_params)

      if @comment.author == ''
          @message = 'Name Required'
      elsif @comment.text == ''
          @message = 'Content Required'
      elsif @comment.save
          @message = 'Added Comment'
      else
          @message = 'Error Saving Comment'
      end
  end

  def show
      @comments = ::Comment.all
      @comment = ::Comment.new
  end
end

private

    def comment_params
        params.require(:comment).permit(:author, :email, :text)
    end

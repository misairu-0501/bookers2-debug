class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id]) #非同期通信のためインスタンス変数に変更

    book_comment = BookComment.new(book_comment_params)
    book_comment.user_id = current_user.id

    book_comment.book_id = @book.id
    book_comment.save

    # redirect_to request.referer #非同期通信のため削除
  end

  def destroy
    @book = Book.find(params[:book_id]) #非同期通信のためインスタンス変数@bookを用意
    book_comment = BookComment.find(params[:id])
    book_comment.destroy

    # redirect_to request.referer #非同期通信のため削除
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end

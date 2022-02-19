class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])

    # comment = current_user.book_comments.new(book_comment_params)
    #上記１行は下記２行と同義
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id

    comment.book_id = book.id
    comment.save

    # redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    #上記１行は下記１行と同義
    redirect_to request.referer #直前のページにリダイレクト
  end

  def destroy
    BookComment.find(params[:id]).destroy

    # redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    #上記１行は下記１行と同義
    redirect_to request.referer #直前のページにリダイレクト
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end

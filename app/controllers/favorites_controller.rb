class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])

    # favorite = current_user.favorites.new(book_id: book.id)
    #上記１行は下記３行と同義
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.book_id = book.id

    favorite.save

    # redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    #上記１行は下記１行と同義
    redirect_to request.referer #直前のページにリダイレクト
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    #上記１行は下記１行と同義
    redirect_to request.referer #直前のページにリダイレクト
  end

end



class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id]) #インスタンス変数@bookとしたのは/bookers2-debug/app/views/favorites/create.js.erbに渡すため

    # favorite = current_user.favorites.new(book_id: @book.id)
    #上記１行は下記３行と同義
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.book_id = @book.id

    favorite.save

    # redirect_to request.referer #非同期通信のため削除
  end

  def destroy
    @book = Book.find(params[:book_id]) #インスタンス変数@bookとしたのは/bookers2-debug/app/views/favorites/destroy.js.erbに渡すため

    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy

    # redirect_to request.referer #非同期通信のため削除
  end

end



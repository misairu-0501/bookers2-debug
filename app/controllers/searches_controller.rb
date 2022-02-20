class SearchesController < ApplicationController

  def search
    @range = params[:range] #検索したモデル名
    @word = params[:word] #検索ワード

    case @range
    when "User"
      @searches = User.looks(params[:search], params[:word]) #Userの検索結果を@searchに格納
    when "Book"
      @searches = Book.looks(params[:search], params[:word]) #Bookの検索結果を@searchに格納
    else
       # 検索するモデルに追加があったら記載
    end

    render result_path #検索結果画面に遷移

  end

end

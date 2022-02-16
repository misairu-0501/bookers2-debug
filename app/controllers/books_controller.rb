class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new #2022/2/16(debug)
    @user = User.find(@book.user_id) #2022/2/16(debug)
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id #2022/2/16(debug)

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    # 2022/2/16(debug)
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  # def delete
  def destroy #2022/2/16(debug)
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    # params.require(:book).permit(:title)
    params.require(:book).permit(:title, :body) #2022/2/16(debug)
  end
end

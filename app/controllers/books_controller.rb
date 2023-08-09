class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
  end

  def edit
  end
  
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash.now[:notice] = "Book was successfully destroyed."
      @books = Book.all
      @book = Book.new
      render :index
    else
      flash.now[:alert] = "Book was not successfully destroyed."
      @books = Book.all
      @book = Book.new
      render :index
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

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
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(book.id)
    else
      flash.now[:alert] = "An error occurred while updating the book"
      @book = Book.find(book.id)
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully destroyed."
      @books = Book.all
      @book = Book.new
      redirect_to books_path
    else
      flash.now[:alert] = "An error occurred while destroying the book."
      @books = Book.all
      @book = Book.new
      redirect_to books_path
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

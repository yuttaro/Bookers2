class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render"index"
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user!=current_user
      redirect_to books_path
    end
  end

  def update

    @book = Book.find(params[:id])

      if @book.update(book_params)

        flash[:notice] = "successfully"
        redirect_to book_path(@book.id)
      else
        render  "edit"
      end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end

end

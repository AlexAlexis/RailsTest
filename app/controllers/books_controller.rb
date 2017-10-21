class BooksController < ApplicationController

  layout 'book'

  def index
  	@books = Book.all.paginate(page: params[:page], per_page: 20)
    @top = Book.first_five
  end

  def show
   @book = Book.find(params[:id])
  end

  def new
   @book = Book.new
  end

  def create
   	@book = Book.new(book_params)
    @book.save
  	redirect_to(root_path)

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book = @book.update_attributes(book_params)
    redirect_to(root_path)
  end

  def delete
    @book = Book.find(params[:id])
    if (@book.usertake == current_user.email || @book.usertake == nil)
      @book.destroy
      flash[:notice] = "Hope you did vise destroying #{@book.name}"
      redirect_to(root_path)
    else
      flash[:notice] = "Don't destroy something that's now yours"
      redirect_to(root_path)
    end
  end

  def destroy
  	@book = Book.find(params[:id])
    if (@book.usertake == current_user.email || @book.usertake == nil)
    @book.destroy
    flash[:notice] = "Hope you did vise destroying #{@book.name}"
    redirect_to(root_path)
    else
      flash[:notice] = "You can't destroy something that's now yours"
      redirect_to(root_path)
    end

  end

  def tbutton
    @book = Book.find(params[:id])
    if (@book.usertake == current_user.email || @book.usertake == nil)
    @book.take = 'Is taken by: '
    @book.usertake = current_user.email
    @book.save
    redirect_to(root_path)
    flash[:notice] = "Hope you will Have a good time reading this shit"
    else
      flash[:notice] = "Book has been already taken by: #{@book.usertake}, wait for him to drop"
      redirect_to(book_path)
      end
  end

  def dbutton
    @book = Book.find(params[:id])
    if @book.usertake == current_user.email
      @book.take = "Avaliable"
      @book.usertake = nil
      @book.save
      flash[:notice] = "Hope it was interesting!"
      redirect_to(root_path)
    else
      flash[:notice] = "You can't give something that is not yours, it belongs to: #{@book.usertake}, wait for him to drop.'"
      redirect_to(book_path)
    end
  end

  private

  def book_params
   params.require(:book).permit(:name, :author, :description, :image, :rating)
  end



end

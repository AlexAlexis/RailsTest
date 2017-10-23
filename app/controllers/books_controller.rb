class BooksController < ApplicationController


  def index
  	@books = Book.all.paginate(page: params[:page], per_page: 20)
    @top = Book.first_five
  end

  def show
   @book = Book.find(params[:id])
   @history = Hist1.all   
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

  def take
    @book = Book.find(params[:id])
    if @book.can_take? current_user
      @book.update(take: 'Is taken by: ', usertake: current_user.email)   
      Hist1.create(whotake: current_user.email)    
      redirect_to(root_path)
      flash[:notice] = "Hope you will Have a good time reading this shit"
    else
      flash[:error] = "Book has been already taken by: #{@book.usertake}, wait for him to drop"
      redirect_to(book_path)
    end
  end

  def return
    @book = Book.find(params[:id])
    if @book.usertake == current_user.email
      @book.take = "Avaliable"
      @book.usertake = nil
      @book.save
      history = Hist1.last
      history.whenreturn = @book.updated_at
      history.save
      flash[:notice] = "Hope it was interesting!"
      redirect_to(root_path)
    else
      flash[:notice] = "You can't give something that is not yours, it belongs to: #{@book.usertake}, wait for him to drop.'"
      redirect_to(book_path)
    end
  end

  private

  def book_params
   params.require(:book).permit(:name, :author, :description, :image, :rating, :usertake, :take)
  end



end

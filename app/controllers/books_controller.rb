class BooksController < ApplicationController

  before_action :find_books, only: [:show, :edit, :update, 
    :delete, :take, :return, :create_comment]
  before_action :store_location, only: [:delete_comment]
  def index
  	@books = Book.all.paginate(page: params[:page], per_page: 20)
    @top = Book.first_five
  end

  def show   
   @history = Hist1.where(book_id: @book.id)
   @comment1 = Comment.new
   @comment = Comment.where(book_id: @book.id)    
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
  end

  def update    
    @book = @book.update_attributes(book_params)
    redirect_to(root_path)
  end

  def delete    
    if @book.can_delete? current_user.email
      @book.destroy
      flash[:notice] = "Hope you did vise destroying #{@book.name}"
      redirect_to(root_path)
    else
      flash[:notice] = "Don't destroy something that's now yours"
      redirect_to(root_path)
    end
  end  

  def take    
    if @book.can_take? current_user
      @book.update(take: 'Is taken by: ', usertake: current_user.email)   
      Hist1.create(whotake: current_user.email, whentake: @book.updated_at,
        book_id: @book.id)    
      redirect_to(root_path)
      flash[:notice] = "Hope you will Have a good time reading this shit"
    else
      flash[:error] = "Book has been already taken by: #{@book.usertake}, wait for him to drop"
      redirect_to(book_path)
    end
  end

  def return    
    if @book.can_return? current_user.email
      @book.update(take: 'avaliable', usertake: nil)
      @history = Hist1.where(book_id: @book.id).last.update_attributes(whenreturn: @book.updated_at)      
      flash[:notice] = "Hope it was interesting!"
      redirect_to(root_path)
    else
      flash[:notice] = "You can't give something that is not yours, it belongs to: #{@book.usertake}, wait for him to drop.'"
      redirect_to(book_path)
    end
  end

  def create_comment
     @book_id = @book.id
     @comment = Comment.create(username: current_user.email, book_id: @book_id,
      usertext: params[:usertext])
     redirect_to(book_path)   
  end

  def delete_comment       
    @comment = Comment.find(params[:id])
    book1 = Book.find(@comment.book_id)       
    @comment.destroy
     flash[:notice] = "Comment deleted"    
    redirect_to(book_path(book1))    #redirect_to(book_path)
  end

  private

  def book_params
   params.require(:book).permit(:name, :author, :description, :image, :rating, :usertake, :take)
  end

  def find_books
    @book = Book.find(params[:id])    
  end

  def comment_params
    params.require(:commnt).permit(:username,:book_id, :usertext)      
    end  

    def store_location
    session[:return_to] = request.fullpath
    end

end

class CommentsController < ApplicationController

  


  def edit
  	
  end

  def delete
  	@comment = Comment.last
    @comment.destroy
    redirect_to(book_path)
  end

end

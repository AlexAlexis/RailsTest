class AddColumnWithRating < ActiveRecord::Migration[5.1]

  def up
    add_column('books', 'rating', :integer, :after => 'name')
  end

  def down
    remove_column('books', 'rating')
  end

end

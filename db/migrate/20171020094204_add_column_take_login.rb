class AddColumnTakeLogin < ActiveRecord::Migration[5.1]


  def up
    add_column('books', 'take', :string, default: 'Avaliable' )
    add_column('users', 'login1', :string)
    add_column('books', 'usertake', :string)
  end

  def down
    remove_column('books', 'usertake')
  remove_column('users', 'login1')
  remove_column('books', 'take')
  end
end

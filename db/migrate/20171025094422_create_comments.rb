class CreateComments < ActiveRecord::Migration[5.1]
  def up
    create_table :comments do |t|
      t.column "book_id", :integer
      t.string "username"
      t.text "usertext"
      t.timestamps
    end
    add_index("comments", "book_id")
  end

  def down
	drop_table :comments		 	
	end	 
end

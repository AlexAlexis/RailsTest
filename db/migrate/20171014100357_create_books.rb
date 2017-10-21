class CreateBooks < ActiveRecord::Migration[5.1]
  def up
    create_table :books do |t|
    	t.column "name", :string, :limit => 50
    	t.column "description", :text
    	t.string "author", :limit => 20
    	t.boolean "status", :default => false
    	t.integer "position"


      t.timestamps
    end
  end

  def down
  	drop_table :books
  end
  
end

class CreateHist1s < ActiveRecord::Migration[5.1]
  def up
    create_table :hist1s do |t|
      t.column "whotake", :string
      t.string "whentake"
      t.string "whenreturn"
      t.integer "book_id"	

      t.timestamps
    end
    add_index("hist1s", "book_id")
  end

  def down
  	drop_table :hist1s
  end
end

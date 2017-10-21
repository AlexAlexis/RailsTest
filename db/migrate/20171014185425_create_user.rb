class CreateUser < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
    end
  end

  def down
  	drop_table :users
  end
end

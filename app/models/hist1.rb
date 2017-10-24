class Hist1 < ApplicationRecord

	belongs_to :book

	#scope :bookhistory, -> { where(book_id: @book.id) } 

end

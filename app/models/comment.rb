class Comment < ApplicationRecord

	belongs_to :book


	def can_delete?(user)
		username == user		
	end
	
	validates_presence_of :usertext

end

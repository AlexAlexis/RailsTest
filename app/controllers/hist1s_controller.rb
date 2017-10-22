class Hist1sController < ApplicationController

	def index
		@history = Hist1.all
	end
end

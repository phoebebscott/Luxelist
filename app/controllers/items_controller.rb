class ItemsController < ApplicationController
	before_action :set_item

	def index
		@items = Items.party(params[:heading])
	end

	def show
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

end

private
# Use callbacks to share common setup or constraints between actions.
	def set_item
	  @item = Item.find(params[:id])
	end

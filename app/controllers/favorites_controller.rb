class FavoritesController < ApplicationController
wrap_parameters format: :json
respond_to :json, :html

def index
	@favorites = Favorite.all
	respond_with @favorites
end

def show
end

def new

end

def create
# use the items to create favorites off of them. @item exists when there is an external id. .first is only pulling the first item id that is found vs. all of the possible external ids.
	@item = Item.where(external_id: item_params[:external_id]).first

# create item in the db so that can associate with a favorite.
	if @item == nil
		@item = Item.create(item_params)
	end

# create a favorite and connect the "belongs to" relationship with user & item
	 @favorite = @item.favorites.new(user: current_user)

	#@favorite = Favorite.new(favorite_params)

# pull in json to save the favorite
    if @favorite.save
      respond_to do |format|
        format.html { redirect_to items_path }
        format.json { render json: @favorite, status: :created }
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
end

def destroy
end

protected

# item params used here to connect item to favorites
	def item_params
    params.require(:item).permit(:external_id, :external_url, :image_url, :user_id)
  end

end


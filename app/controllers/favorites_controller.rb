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

  # create item in the db so that can associate with a favorite.
	@item = Item.create!(item_params)

  # create a favorite and connect the "belongs to" relationship with user & item
  @favorite = Favorite.create(
    user_id: @current_user,
    price: @item.price,
    external_id: @item.external_id,
    external_url: @item.external_url,
    image_url: @item.image_url,
    heading: @item.title,
    cityName: @item.location
  )

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
    params.require(:item).permit(:external_id, :external_url, :image_url, :user_id, :title, :price, :location
)
  end

end


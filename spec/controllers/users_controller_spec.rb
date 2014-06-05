require 'spec_helper'

describe UsersController do

	describe "GET new" do
	    it "returns http success" do
	    	get 'new'
	    	expect(response).to be_success
	    end
# test that the user is instance of User Class, but is not saved in database
	    it "should assign a user" do
	    	get 'new'
	    	expect(assigns[:user]).to be_a(User)
	    	expect(assigns[:user]).to_not be_persisted
	    end
	end

	describe "POST create" do
	  describe "successful create" do
	    	let :valid_attributes do
	    		{
	    			:email => "jane@doe.com",
	    			:password => "123456",
	    			:password_confirmation => "123456",
	    		}
	    	end
	    # this tests if the user is being saved to the db
	      it "should create a new user" do
	        expect do
	          post :create, :user => valid_attributes
	        end.to change(User, :count).by(1)
	      end

	      it "should redirect to root" do
	      	post :create, :user => valid_attributes
	      	expect(response).to redirect_to root_path
				end
		end

  	describe "unable to save" do

    	# Need to make the attributes invalid in order to test them. R-name to invalid and create one as nil because requires presence of is part of model.
	    let :invalid_attributes do
			{
			:email => "jane@doe.com",
			:password => nil,
			:password_confirmation => nil
			}
			end

		# this tests if the user is being saved as a record in the database
	    it "should not create any new records in the database" do
	        expect do
	          post :create, user: invalid_attributes
	        end.to_not change(User, :count).by(1)
	    end

	    # this tests if the user is being shown the same page if they are not saved
	    it "should rerender the new template" do
	        post :create, user: invalid_attributes
	        expect(response).to render_template :new
	    end
		end
	end
end


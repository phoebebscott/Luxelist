require 'spec_helper'

describe UsersController do
	
	# DRY testing: adding attributes that use when testing each function without repeating code
	let :valid_attributes do
		{
			:first_name => "Jane",
			:email => "jane@doe.com",
			:password => "123456"
		}
	end


	describe "GET new" do
	    
	    # summon the new action before running each test
	    before do
	      get :new
	    end

	    # test that new.html.erb exists
	    it "should render the new template" do
	      expect(response).to render_template :new
	    end

	    # test that the server responds to the call with "200"
	    it "should succeed" do
	      expect(response).to be_success
	    end

	    # test that the user is instance of User Class, but is not saved in database
	    it "should assign user to be a new user" do
	      expect(assigns(:user)).to be_a(User)
	      expect(assigns(:user)).to_not be_persisted
	    end
	end


	describe "POST create" do
	    describe "successful create" do

	    # this tests if the user is being saved to the db
	      it "should create a user in the database" do
	        expect do
	          post :create, user: valid_attributes
	        end.to change(User, :count).by(1)
	      end
		end

		# this tests if the user is being re-directed to the landing page after being saved
	      it "should redirect to the landing page" do
	        post :create, user: valid_attributes
	        expect(response).to redirect_to users_path
	      end
    end


    describe "unable to save" do
	    
    	# Need to make the attributes invalid in order to test them. R-name to invalid and create one as nil because requires presence of is part of model.
	    let :invalid_attributes do
			{
			:first_name => "Jane",
			:email => "jane@doe.com",
			:password => nil
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

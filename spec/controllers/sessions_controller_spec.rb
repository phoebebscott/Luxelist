require 'spec_helper'

describe SessionsController do
  let! :user do
    User.create(
      :email => "will@will.com",
      :password => "henry"
      )
  end

  describe "GET 'new'" do
    it "returns http success" do
      redirect_to(root_path)
      response.should be_success
    end
  end

  describe "POST 'create'" do

  	let :session_params do
	    {
	      :email => "mary@mary.com",
	      :password => "cooper"
	    }
      end

    describe "an incorrect login" do
      it "should not login" do
        post :create, :session => session_params
        flash[:error].should == 'Invalid email/password combination'
      end

      it "should render login form again" do
        post :create, :session => session_params
        response.should render_template('new')
      end
    end


  end

end

require 'spec_helper'

describe User do

    it { should have_db_column(:email) }
    it { should have_db_column(:password_digest) }

    it "matches confirmation of password" do
      @user = User.new(:email =>"jane@doe.com", :password => "123456", :password_confirmation => "654321")
      expect(@user).to be_invalid
    end

  	it "is not a valid user without an email address" do
  		person = User.new(password: "123456")
  		expect(person).to be_invalid
  	end

  	it "is not a valid user without a password" do
  		person = User.new(email: "jane@doe.com")
  		expect(person).to be_invalid
  	end

  	it "is not a valid user without a unique email address" do
  		person = User.create(email: "jane@doe.com", password: "123456")
  		person2 = User.new(email: "jane@doe.com", password: "123456")
  		expect(person2).to be_invalid
  	end

    # makes sure that user inputs an email address that exists using regex in model
    it "is not a valid user without a complete and valid email address" do
      person = User.new(email: "janedoe.com", password: "123456")
      expect(person).to be_invalid
    end

  	it "is only a valid user if password length is at least six characters" do
  		person = User.new(email: "jane@doe.com", password: "1234")
  		expect(person).to be_invalid
  	end


end

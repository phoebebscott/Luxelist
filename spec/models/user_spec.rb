require 'spec_helper'

describe User do
    
    # Not sure if this first test is necessary, given the individual tests below
    it "is a valid user that has a first name, email and password" do
	  	person = User.new(first_name: "Jane", email: "jane@doe.com", password: "123456")
	  	expect(person).to be_valid
  	end

  	it "is not a valid user without a name" do
  		person = User.new(email: "jane@doe.com", password: "123456")
  		expect(person).to be_invalid
  	end

  	it "is not a valid user without an email address" do
  		person = User.new(first_name: "Jane", password: "123456")
  		expect(person).to be_invalid
  	end

  	it "is not a valid user without a password" do
  		person = User.new(first_name: "Jane", email: "jane@doe.com")
  		expect(person).to be_invalid
  	end

  	it "is not a valid user without a unique email address" do
  		person = User.create(first_name: "Jane", email: "jane@doe.com", password: "123456")
  		person2 = User.new(first_name: "Jane", email: "jane@doe.com", password: "123456")
  		expect(person2).to be_invalid
  	end

    # makes sure that user inputs an email address that exists using regex in model
    it "is not a valid user without a complete and valid email address" do
      person = User.new(first_name: "Jane", email: "janedoe.com", password: "123456")
      expect(person).to be_invalid
    end

  	it "is only a valid user if password length is at least six characters" do
  		person = User.new(first_name: "Jane", email: "jane@doe.com", password: "1234")
  		expect(person).to be_invalid
  	end


end

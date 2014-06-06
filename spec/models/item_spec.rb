require 'spec_helper'

describe Item do
	it "is not a valid item without a title" do
		item = Item.new(price: 100, location: "US-CA-LAX")
		expect(item).to be_invalid
  end

  it "is not a valid item without a location" do
  	item = Item.new(title: "sofa", price: 100)
		expect(item).to be_invalid
  end

	it "is not a valid item without a price" do
		item = Item.new(title: "sofa", location: "US-CA-LAX")
		expect(item).to be_invalid
	end
  it { should have_many(:favorites)}
  it { should have_many(:users)}
end

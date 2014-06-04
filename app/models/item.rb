class Item < ActiveRecord::Base
	has_many :favorites
	has_many :users, through: :favorites

	def self.party(heading)
		# If no search specified, use Sofa
		heading ||= "sofa"

		# Authentication key for 3tapsAPI:
		auth = { query: { auth_token: '<a3d09bcb83580db63e9fd0cac1af5cac>' }} # Adds to end of URL ?auth_token=<APITOKEN>&q=<heading>
		search_url = "http://http://search.3taps.com/"
		
		response = HTTParty.get search_url, auth

		auth = { query: { auth_token: '<a3d09bcb83580db63e9fd0cac1af5cac>' }}
		
		# id = # INSERT CODE HERE: Get the value of 'movies' 0 'id' in the nested response hash
				 # HINT: It should be something like this: response['stuff'][1]['morestuff']
		craigslistAPI_url = "http://search.3taps.com/"

		response = HTTParty.get craigslistAPI_url, auth
		
	end
end

class Query < ActiveRecord::Base
	# each query can have many items returned through query_results
	has_many :query_results
	has_many :items, through: :query_results
end

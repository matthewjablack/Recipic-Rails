class Item < ApplicationRecord
	has_many :recipeitems
	has_many :recipes, :through => :recipeitems
end

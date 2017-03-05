class Recipe < ApplicationRecord
	has_many :items, :through => :recipeitems
end

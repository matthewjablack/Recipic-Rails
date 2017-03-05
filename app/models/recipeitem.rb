class Recipeitem < ApplicationRecord
	belongs_to :recipe
	belongs_to :item
end

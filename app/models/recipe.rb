class Recipe < ApplicationRecord
	has_many :recipeitems
	has_many :items, :through => :recipeitems

	def self.with_items(*item_ids)
		joins(:items).where(items: {id: item_ids}).group("recipes.id").select("recipes.*, COUNT(items.id) AS match_count").order("match_count")
	end

end

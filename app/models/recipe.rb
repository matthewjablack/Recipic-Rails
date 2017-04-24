class Recipe < ApplicationRecord
	has_many :recipeitems
	has_many :items, :through => :recipeitems

	def self.with_items(*item_ids)
		joins(:items).where(items: {id: item_ids}).select("#{table_name}.*, COUNT(#{Item.table_name}.id AS match_count").group("#{table_name}.id").order(:match_count)
	end
end

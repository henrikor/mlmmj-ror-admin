class Liste < ActiveRecord::Base
	has_and_belongs_to_many :groups

	def self.lists_for_user(user)
		lists = Array.new
		user.groups.each do |group|
			glist = Liste.joins(:groups).where("group_id = ?", group.id)
	        glist.each do |list|
	        	lists << list unless lists.include? list
	        end
		end
		return lists
	end
end

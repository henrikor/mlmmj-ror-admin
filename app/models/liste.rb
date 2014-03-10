class Liste < ActiveRecord::Base
	has_and_belongs_to_many :groups
	has_many :changes

	def self.lists_for_user(user)
		if user.admin?
			lists = self.all
		else
			lists = Array.new
			user.groups.each do |group|
				glist = Liste.joins(:groups).where("group_id = ?", group.id)
				glist.each do |list|
					lists << list unless lists.include? list
				end
			end
		end
		return lists
	end

	# metoden under er pt. ikke ibruk
	def self.can_admin?(user, list)
		if lists_for_user.include(list)
			return true
		else
			return false
		end
	end

	def self.subscribers(listeid)
		liste = self.find(listeid)
		`/usr/bin/mlmmj-list -L #{liste.bane}`
	end

	def self.has_adress?(string, listeid)
		members = subscribers(listeid)
		if members =~ listeid
			return true
		else
			return false
		end
	end

	def self.mlmmj_sub(emails, listeid)
		errors = Array.new
		emailsarr = Array.new
		liste = self.find(listeid)
		emails.scan(User.email_regex) { |w| emailsarr << w}
		emailsarr.each do |single|
			if User.email?(single) and not has_adress?(single, listeid)
				result = %x(/usr/bin/mlmmj-sub -L #{liste.bane} -a #{single} 2>&1) 
				errors << result unless result = nil  			
			end
		end
		if errors.any?
			errors[:base] << errors.to_s
			return false
		else
			return true  		
		end
	end


	# def innmeld(adresser)
	# 	adresser.scan(@emailRE) { |w| @adr << w}
	# 	@adr.each{ |x|
	# 		`#{@mlmmj_path}mlmmj-sub -L #{@list_path}#{@listemdomene} -a #{x.strip}`
	# 		`echo "#{@mlmmj_path}mlmmj-sub -L #{@list_path}#{@listemdomene} -a #{x.strip}" >> /tmp/nortest2`
	# 	}
	# end
	# def avmeld(avmeldearr)
	# 	avmlengde = 0
	# 	avmeldearr.each{ |name, value|
	# 		if value == "1"
	# 			`#{@mlmmj_path}mlmmj-unsub -L #{@list_path}#{@listemdomene} -a #{name.strip}`
	# 			`echo "#{@mlmmj_path}mlmmj-unsub -L #{@list_path}#{@listemdomene} -a #{name}" >> /tmp/nortest2`
	# 			avmlengde = avmlengde + 1
	# 		end
	# 	}
	# 	return avmlengde
	# end

end

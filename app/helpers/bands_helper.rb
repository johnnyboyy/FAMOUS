module BandsHelper

	def members_bands(member) 
		return member.bands.map do |b|
			link_to "#{b.name}", band_path(b)
		end.join(", ").html_safe
	end
	
end

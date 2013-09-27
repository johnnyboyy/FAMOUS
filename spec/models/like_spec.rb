require 'spec_helper'

describe Like do
	it "should not allow duplicate likes on the same song" do
		l1 = Like.new(user_id: 1, song_id: 1)
	end
end

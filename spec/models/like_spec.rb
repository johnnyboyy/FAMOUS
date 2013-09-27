require 'spec_helper'

describe Like do
	it "should require a user id and song id" do
		expect(Like.new.save).to eq(false)
	end

	it "should not allow duplicate likes on the same song" do
		l1 = Like.new(user_id: 1, song_id: 1)
		l2 = Like.new(user_id: 1, song_id: 1)
		l1.save

		expect(l2.save).to eq(false)
	end

	it "should allow different users to like the same song" do
		# the uniqueness validater has tripped me up before
		l1 = Like.new(user_id: 1, song_id: 1)
		l3 = Like.new(user_id: 2, song_id: 1)
		l1.save

		expect(l3.save).to eq(true)
	end

	it "should allow a user to like multiple songs" do
		l1 = Like.new(user_id: 1, song_id: 1)
		l4 = Like.new(user_id: 1, song_id: 2)
		l1.save

		expect(l4.save).to eq(true)
	end
end

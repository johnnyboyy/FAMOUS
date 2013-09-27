require 'spec_helper'

describe Song do
 	it "should not save a song without any fields" do
 		test_song = Song.new
 		expect(test_song.save).to eq(false)
 	end

end

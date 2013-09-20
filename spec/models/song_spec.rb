require 'spec_helper'

describe Song do
 	it "should have a title" do
 		test_song = Song.new(title: "test")
 		expect(test_song.title).to eq("test")
 	end

 	it "should have an artist" do 
 		test_song = Song.new(artist: "tester")
 		expect(test_song.artist).to eq("tester")
 	end
 	it "should not save a song without a title and artist" do
 		test_song = Song.new
 		expect(test_song.save).to eq(false)
 	end
 	it "should not save a song with an empty string in title or artist" do
 		test_song = Song.new(title: "", artist: "")
 		expect(test_song.save).to eq(false)
 	end

end

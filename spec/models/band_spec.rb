require 'spec_helper'

describe Band do
  it "should require a user_id" do
  	expect(Band.new.save).to eq(false)
  end

  it "should update songs artist field when bands name is changed" do
    band = Band.new(name: "test_band")
    band.save
    band.songs.build(title: "test_song", artist: band.name).save(validate: false)

    band.name = "different_name"
    band.save(validate: false)

    expect(band.songs.first.artist).to eq('different_name')
  end


end

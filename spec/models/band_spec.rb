require 'spec_helper'

describe Band do
  it "should require a user_id" do
  	expect(Band.new.save).to eq(false)
  end


end

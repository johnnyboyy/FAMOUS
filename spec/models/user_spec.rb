require 'spec_helper'

describe User do
	it "should not allow empty fields" do
		expect(User.new.save).to eq(false)
	end

end

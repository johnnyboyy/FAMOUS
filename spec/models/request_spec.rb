require 'spec_helper'

describe Request do

  let(:req) { Request.new(request_type: "member_request",
                band_id: 1,
                status: "pending",
                sender: 1,
                reciever: 2,
                message: "test" )}
  describe "Basic presence_of tests;" do
    it "should accept a valid request" do
      expect(req.save).to eq(true)
    end
    it "should not allow a blank sender field" do
      req.sender = nil

      expect(req.save).to eq(false)
    end
    it "should not allow a blank band_id field" do
      req.band_id = nil

      expect(req.save).to eq(false)
    end
    it "should not allow a blank status field" do
      req.status = nil

      expect(req.save).to eq(false)
    end
    it "should not allow a blank request_type field" do
      req.request_type = nil

      expect(req.save).to eq(false)
    end
    it "should not allow a blank reciever field" do
      req.reciever = nil

      expect(req.save).to eq(false)
    end
  end
  describe "field specific tests;" do
    it "reciever field should only accept a number" do
        req.reciever = "test"
      expect(req.save).to eq(false)
    end
    it "sender field should only accept a number" do
        req.sender = "test"
      expect(req.save).to eq(false)
    end
    it "band_id field should only accept a number" do
        req.band_id = "test"
      expect(req.save).to eq(false)
    end
    it "status field should not accept 'bad_status'" do
      req.status = "bad_status"

      expect(req.save).to eq(false)
    end
    it "status field should accept 'pending'" do
      req.status = "pending"

      expect(req.save).to eq(true)
    end
    it "status field should not accept 'bad_request'" do
      req.request_type = "bad_request"

      expect(req.save).to eq(false)
    end
    it "status field should accept 'band_request'" do
      req.request_type = "member_request"

      expect(req.save).to eq(true)
    end
  end
end

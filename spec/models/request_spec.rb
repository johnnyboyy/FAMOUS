require 'spec_helper'

describe Request do

  let(:band_req) { Request.new(request_type: "member",
                band_id: 1,
                status: "pending",
                sender: 1,
                reciever: 2,
                message: "test" )}

  let(:book_req) { :band_req[request_type] = "booking" }

  describe "Basic presence_of tests;" do
    it "should accept a valid request" do
      expect(band_req.save).to eq(true)
    end
    it "should not allow a blank sender field" do
      band_req.sender = nil

      expect(band_req.save).to eq(false)
    end
    it "should not allow a blank band_id field" do
      band_req.band_id = nil

      expect(band_req.save).to eq(false)
    end
    it "should not allow a blank status field" do
      band_req.status = nil

      expect(band_req.save).to eq(false)
    end
    it "should not allow a blank request_type field" do
      band_req.request_type = nil

      expect(band_req.save).to eq(false)
    end
    it "should not allow a blank reciever field" do
      band_req.reciever = nil

      expect(band_req.save).to eq(false)
    end
  end
  describe "Field specific tests;" do
    it "reciever field should only accept a number" do
        band_req.reciever = "test"
      expect(band_req.save).to eq(false)
    end
    it "sender field should only accept a number" do
        band_req.sender = "test"
      expect(band_req.save).to eq(false)
    end
    it "band_id field should only accept a number" do
        band_req.band_id = "test"
      expect(band_req.save).to eq(false)
    end
    it "status field should not accept 'bad_status'" do
      band_req.status = "bad_status"

      expect(band_req.save).to eq(false)
    end
    it "status field should accept 'pending'" do
      band_req.status = "pending"

      expect(band_req.save).to eq(true)
    end
    it "request_type field should not accept 'bad_request'" do
      band_req.request_type = "bad_request"

      expect(band_req.save).to eq(false)
    end
    it "request_type field should accept 'member'" do
      band_req.request_type = "member"

      expect(band_req.save).to eq(true)
    end

    
  end
end

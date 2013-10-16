require 'spec_helper'

describe Request do

  let(:band_req) { Request.new(request_type: "member",
                band_id: 1,
                status: "pending",
                sender: 1,
                reciever: 2,
                message: "test" )}

  let(:book_req) { Request.new(request_type: "booking",
                band_id: 1,
                status: "pending",
                sender: 1,
                reciever: 2,
                message: "test",
                pay: 100,
                per: "whole show",
                showtime: DateTime.now + 10.days,
                location: "123a Real Address" )}


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
  describe "Field specific tests:" do
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
  describe "booking requests;" do
    describe "the baiscs:" do 
      it "should not accept an empty pay field" do
        book_req.pay = nil

        expect(book_req.save).to eq(false)
      end
      it "should not accept an empty per field" do
        book_req.per = nil

        expect(book_req.save).to eq(false)
      end
      it "should not accept an empty showtime field" do
        book_req.showtime = nil

        expect(book_req.save).to eq(false)
      end
      it "should not accept an empty location field" do
        book_req.location = nil

        expect(book_req.save).to eq(false)
      end
    end
    describe "slightly more specific:" do 
      it "should accept a number in the pay field" do
        
        expect(book_req.save).to eq(true)
      end
      it "should accept a number in the pay field" do
        book_req.pay = "string"

        expect(book_req.save).to eq(false)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ConvertItemsController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "Input" do
    it "has Only integer number" do
      expect("123456789").to match(/^[0-9]+$/)
      expect("123456789avcd").to match(/^[0-9]+$/)
    end
  end

  describe "Input integer" do
    it "should not have 0 and 1 in integer number" do
      expect("123456789").to match(/^[2-9]+$/)
      expect("2345678769").to match(/^[2-9]+$/)
    end
  end

  describe "Input integer" do
    it "should be length of 10" do
      expect("123456789".size).to eq(10)
      expect("2345678769".size).to eq(10) 		
    end
  end
end
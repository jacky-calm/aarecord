require 'spec_helper'

describe DishesController do

  describe "GET 'vote'" do
    it "returns http success" do
      get 'vote'
      response.should be_success
    end
  end

end

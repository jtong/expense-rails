require 'rails_helper'

RSpec.describe "User Aggregation Root", type: :request do

  describe "users Resources" do

    before(:each) do
      User.delete_all
      User.create({name: "James"})
      User.create({name: "Tom"})
    end
    
    it "get users" do

      get "/users"
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json[0]['name']).to eq("James")
    end

    it "create users" do

      post "/users", {
          name: "NewJames"
      }
      expect(response).to have_http_status(201)

      json = JSON.parse(response.body)
      # puts json
      expect(json['name']).to eq("NewJames")
    end



  end

end
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "list users" do
    it "get users" do

      get :index
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json.size).to eq(2)
      expect(json[0]['name']).to eq("James")
    end

    # xit "return 404 is user not found" do
    #   game = User.new
    #   game.stub(:get_player).with(1).and_return nil
    #   controller.game = game
    #
    #   get :index, player_id: 1, format: :json
    #   expect(response).to have_http_status(404)
    # end
  end

end
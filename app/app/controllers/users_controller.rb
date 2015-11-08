class UsersController < ApplicationController

  
  def index
    @users = User.all() #TODO: find by query in future
    result = @users.as_json
    result.each do |user|
      jsonize(user)
    end

    render json: result, status: 200
  end


  def create
    # p params[:name]
    user_created = User.create({name: params[:name]})
    # p user_created
    render json: jsonize(user_created), status: 201
  end
  
  def get
    @user = User.find(params[:userId])
    render json: jsonize(@user.as_json), status: 200
  end
  
    def jsonize(user)
      user[:uri] = "/users/#{user["_id"]}";
      user[:id] = user["_id"].to_s
      user
    end
end

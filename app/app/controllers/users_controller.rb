class UsersController < ApplicationController

  
  def index
    @users = User.all() #TODO: find by query in future
    result = @users.as_json
    result.each do |user|
      user[:uri] = "/users/#{user["_id"]}";
    end

    render json: result, status: 200
  end

  def create
    # p params[:name]
    user_created = User.create({name: params[:name]})
    # p user_created
    render json: user_created, status: 201
  end
end

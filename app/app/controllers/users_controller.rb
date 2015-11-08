class UsersController < ApplicationController


  def index
    users = User.find() #TODO: find by query in future
    users.each do |user|
      user.uri = "/users/#{user.id}"
    end
    render text: users.to_json
  end

end

class User
  include Mongoid::Document
  # attr_accessor :uri
  field :name, type: String
  field :uri, type: String
end

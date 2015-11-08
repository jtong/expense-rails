class User
  include Mongoid::Document
  # attr_accessor :uri
  field :name, type: String
  has_many :expenseRequest
end

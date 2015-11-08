class ExpenseRequest
  include Mongoid::Document
  # attr_accessor :uri
  field :requester, type: User
  field :requestDate, type: Date
  belongs_to :user
end
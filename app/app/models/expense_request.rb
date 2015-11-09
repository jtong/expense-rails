class ExpenseRequest
  include Mongoid::Document
  # attr_accessor :uri
  field :requester, type: User
  field :approver, type: User
  field :requestDate, type: Date
  field :name, type:String
  field :amount, type: Float, default: 0.0
  field :status, type: String, default: "REQUEST"
  has_one :user, as: :requester
  has_one :user, as: :approver
end

# frozen_string_literal:true

# Recurrence Model
class Recurrence
  include Mongoid::Document

  EVERY = %w[day week month year].freeze
  ON = (1..31).to_a.concat %w[first second third fourth fifth].freeze
  INTERV = (1..31).to_a.concat %w[monthly bimonthly quarterly semesterly].freeze

  field :every, type: String
  field :on
  field :interval
  field :repeat, type: Integer

  has_many :financial_transactions

  validates :every, presence: true
  validates :every, inclusion: EVERY
  validates :on, inclusion: ON
  validates :interval, inclusion: INTERV
end

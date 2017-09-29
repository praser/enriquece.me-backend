# frozen_string_literal: true

# Financial Transaction Model
class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :destination_account_id

  before_create :build_transfer_destination, if: :destination_account_id
  before_update :change_transfer_associated_attributes, if: :transfer?
  before_destroy :destroy_associated, if: :transfer?

  field :description, type: String
  field :price, type: Float
  field :date, type: Date
  field :paid, type: Boolean, default: false
  field :note, type: String

  belongs_to :account
  belongs_to :category
  belongs_to :subcategory, optional: true
  belongs_to :recurrence, optional: true
  belongs_to :user

  belongs_to(
    :transfer_origin,
    class_name: 'Transaction',
    foreign_key: :transfer_origin_id,
    optional: true,
    autosave: true
  )

  belongs_to(
    :transfer_destination,
    class_name: 'Transaction',
    foreign_key: :transfer_destination_id,
    optional: true,
    autosave: true
  )

  validates :description, presence: true

  validates :price, presence: true
  validates :price, numericality: true

  validates :date, presence: true

  accepts_nested_attributes_for :recurrence

  def transfer?
    transfer_origin? || transfer_destination?
  end

  private

  def transfer_attributes
    attr = attributes.except(
      '_id',
      'account_id',
      'transfer_origin_id',
      'transfer_origin',
      'transfer_destination_id',
      'transfer_destination',
      'price',
      'created_dt',
      'updated_at'
    )

    attr[:price] = -price
    attr[:account_id] = destination_account_id

    attr
  end

  def build_transfer_destination
    self.transfer_destination = Transaction.new(transfer_attributes)
    transfer_destination.transfer_origin = self
  end

  def change_transfer_associated_attributes
    return transfer_origin.attributes = transfer_attributes if transfer_origin?
    transfer_destination.attributes = transfer_attributes
  end

  def destroy_associated
    return transfer_origin.delete if transfer_origin?
    transfer_destination.delete
  end
end

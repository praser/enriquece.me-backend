# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to have_field(:description).of_type(String) }
  it { is_expected.to validate_presence_of :description }

  it { is_expected.to have_field(:price).of_type(Float) }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_numericality_of :price }

  it do
    is_expected.to have_field(:paid).of_type(
      Mongoid::Boolean
    ).with_default_value_of(false)
  end

  it { is_expected.to have_field(:date).of_type(Time) }
  it { is_expected.to validate_presence_of(:date) }

  it { is_expected.to have_field(:note).of_type(String) }

  it { is_expected.to belong_to :account }
  it { is_expected.to respond_to :account }
  it { is_expected.to validate_presence_of :account }

  it { is_expected.to belong_to :category }
  it { is_expected.to respond_to :category }
  it { is_expected.to validate_presence_of :category }

  it { is_expected.to belong_to :subcategory }
  it { is_expected.to respond_to :subcategory }

  it { is_expected.to belong_to :user }
  it { is_expected.to respond_to :user }

  it { is_expected.to belong_to :recurrence }
  it { is_expected.to respond_to :recurrence }
  it { is_expected.to accept_nested_attributes_for :recurrence }

  it { is_expected.to belong_to :transfer_destination }

  it { is_expected.to belong_to :transfer_origin }

  it { is_expected.to respond_to :transfer? }

  context 'transfer' do
    let(:origin) do
      FactoryGirl.create(
        :transaction,
        destination_account_id: FactoryGirl.create(:account).id.to_s
      )
    end

    it 'returns true in transfer? method' do
      expect(origin.transfer?).to be_truthy
    end

    it 'the destination price must have the oposite value of origin price' do
      expect(origin.transfer_destination.price).to be_equal(origin.price * -1)
    end

    it 'creates the destination transaction' do
      transaction = FactoryGirl.create(
        :transaction,
        destination_account_id: FactoryGirl.create(:account).id.to_s
      )
      expect(transaction.transfer_destination).to be_a(Transaction)
    end

    it 'updates the destination when origin changes' do
      expect do
        origin.update_attributes(FactoryGirl.attributes_for(:transaction))
      end.to change(origin.transfer_destination, :attributes)
    end

    it 'updates the origin trasaction when destination changes' do
      destination = origin.transfer_destination
      expect do
        destination.update_attributes(FactoryGirl.attributes_for(:transaction))
      end.to change(origin, :attributes)
    end

    it 'destroys the destination when origin is deleted' do
      origin.destroy
      expect(origin.destroyed?).to be_truthy
      expect(origin.transfer_destination.destroyed?).to be_truthy
    end

    it 'destroys the origin when destination is deleted' do
      origin.transfer_destination.destroy
      expect(origin.destroyed?).to be_truthy
      expect(origin.transfer_destination.destroyed?).to be_truthy
    end
  end

  context 'is not transfer' do
    let(:trans) { FactoryGirl.create(:transaction) }

    it 'returns false in transfer? method' do
      expect(trans.transfer?).to be_falsey
    end
  end
end

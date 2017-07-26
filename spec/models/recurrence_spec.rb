# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recurrence, type: :model do
  let(:every) { %w[day week month year] }
  let(:on) { (1..31).to_a.concat %w[first second third fourth fifth] }
  let(:interv) do
    (1..31).to_a.concat %w[monthly bimonthly quarterly semesterly]
  end

  it { is_expected.to have_field(:every).of_type(String) }
  it { is_expected.to validate_presence_of :every }
  it { is_expected.to validate_inclusion_of(:every).to_allow(every) }

  it { is_expected.to have_field(:on) }
  it { is_expected.to validate_inclusion_of(:on).to_allow(on) }

  it { is_expected.to have_field(:interval) }
  it { is_expected.to validate_inclusion_of(:interval).to_allow(interv) }

  it { is_expected.to have_field(:repeat).of_type(Integer) }

  it { is_expected.to have_many :transactions }
end

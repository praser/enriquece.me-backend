# frozen_string_literal: true

# Concern to handle date interval received through uri
module DateIntervalParams
  extend ActiveSupport::Concern

  included do
    attr_reader :start_date, :end_date
    before_action :set_start_date
    before_action :set_end_date
  end

  def set_start_date
    @start_date = if params[:start].nil?
                    Time.current.at_beginning_of_month
                  else
                    Time.zone.parse(params[:start])
                  end
  end

  def set_end_date
    @end_date = if params[:end].nil?
                  Time.current.at_end_of_month
                else
                  Time.zone.parse(params[:end])
                end
  end
end

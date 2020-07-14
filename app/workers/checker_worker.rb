# frozen_string_literal: true

require 'sidekiq-scheduler'

class CheckerWorker
  include Sidekiq::Worker

  def perform
    domains = Domain.all
    domains.each do |domain|
      domain.update_status
    end
  end
end

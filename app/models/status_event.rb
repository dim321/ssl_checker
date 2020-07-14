# frozen_string_literal: true

# == Schema Information
#
# Table name: status_events
#
#  id         :bigint           not null, primary key
#  message    :string
#  domain_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class StatusEvent < ApplicationRecord
  belongs_to :domain
end

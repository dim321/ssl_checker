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
require 'test_helper'

class StatusEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

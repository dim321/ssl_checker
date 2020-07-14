# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Domain < ApplicationRecord
  has_many :status_events, dependent: :destroy
end

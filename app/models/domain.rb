# frozen_string_literal: true

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


require 'net/http'
#require 'openssl'

class Domain < ApplicationRecord
  has_many :status_events, dependent: :destroy

  after_create :update_status #при добавлении нового домена сразу производится проверка сертификата

  ONE_WEEK = 7  * 86400
  TWO_WEEK = 14 * 86400

  def get_cert
    uri = URI::HTTPS.build(host: self.name)
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true)
    response.peer_cert
  end

  def check_ssl
    begin
      certificate = get_cert

    rescue SocketError, SystemCallError
      return { status: false, message: "Bad url, no SSL error" }
    rescue Net::OpenTimeout
      return { status: false, message: "Timed out, no SSL error" }
    rescue OpenSSL::SSL::SSLError
      return { status: false, message: "SSL Error" }
    end

    time_remaining = certificate.not_after - Time.now

    case time_remaining
      when (...0)
        return { status: false, message: "Certificate expired" }
      when (0..ONE_WEEK)
        return { status: false, message: "Certificate will expire in less one week" }
      when (ONE_WEEK...TWO_WEEK)
        return { status: false, message: "Certificate will expire in less two week" }
      when (TWO_WEEK..)
        return { status: true, message: "All right" }
    end

    return "Something wrong"
  end

  def update_status
    if self.status_events.empty?
      last_message = "no_messages"
    else
      last_message = self.status_events.last.message #последнее сообщение в журнале событий для данного домена
    end
      current_result = self.check_ssl # текущий результат проверки сертификата для данного домена

    # Если предыдущее сообщение в журнале событий для данного домена отличается от полученного
    # в результате текущей проверки, то добавляем новое сообщение в журнал и обновляем статус домена
    unless current_result[:message] == last_message
      self.status_events.create({message: current_result[:message]})
      self.update_attribute(:status, current_result[:status])
    end
  end

end

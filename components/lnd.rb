# frozen_string_literal: true

require 'singleton'

require 'lnd-client'

class LND
  include Singleton

  attr_reader :client

  def initialize
    @client = LNDClient.new(
      certificate_path: ENV.fetch('LND_STREAMS_CERTIFICATE_PATH', nil),
      macaroon_path: ENV.fetch('LND_STREAMS_MACAROON_PATH', nil),
      socket_address: ENV.fetch('LND_STREAMS_LND_ADDRESS', nil)
    )
  end
end

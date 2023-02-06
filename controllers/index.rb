# frozen_string_literal: true

require_relative 'events'

module IndexController
  def self.handler
    {
      service: 'lnd-streams',
      version: '0.0.1',
      lnd: ENV.fetch('LND_STREAMS_LND_ADDRESS', nil),
      redpanda: ENV.fetch('LND_STREAMS_REDPANDA_ADDRESS', nil),
      topics: EventsController.instance.topics
    }
  end
end

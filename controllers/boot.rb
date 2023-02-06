# frozen_string_literal: true

require_relative '../components/log'
require_relative 'events'

module BootController
  def self.boot!
    EventsController.instance.create_topics!
    EventsController.instance.start_producers!

    Log.instance.logger.info("Starting server on port #{ENV.fetch('LND_STREAMS_PORT', nil)}")
  end
end

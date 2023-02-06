# frozen_string_literal: true

require 'singleton'

require 'rdkafka'

class Redpanda
  include Singleton

  attr_reader :broker

  def initialize
    @redpanda_address = ENV.fetch('LND_STREAMS_REDPANDA_ADDRESS')

    @broker = Rdkafka::Config.new({ 'bootstrap.servers': @redpanda_address })

    @groups = {}
  end

  def group(id)
    @groups[id] ||= Rdkafka::Config.new({
                                          'bootstrap.servers': @redpanda_address, 'group.id': id
                                        })
  end
end

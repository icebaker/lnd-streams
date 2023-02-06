# frozen_string_literal: true

require 'singleton'

require_relative '../components/redpanda'

class RedpandaPort
  include Singleton

  def initialize
    @producers = {}
  end

  def create_topic(topic_name, partition_count, replication_factor)
    Redpanda.instance.broker.admin.create_topic(topic_name, partition_count, replication_factor)
  end

  def produce(topic, data)
    @producers[topic] = Redpanda.instance.broker.producer unless @producers[topic]

    @producers[topic].produce(topic:, payload: JSON.generate(data))
  end
end

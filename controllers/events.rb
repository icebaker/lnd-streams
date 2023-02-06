# frozen_string_literal: true

require 'singleton'

require_relative '../components/log'
require_relative '../components/lnd'
require_relative '../ports/redpanda'

class EventsController
  include Singleton

  attr_reader :topics

  def initialize
    @topics = []
  end

  def create_topics!
    %w[router lightning].each do |service|
      method_names = LND.instance.client.send(service).doc.available_methods.filter do |method_name|
        method_name =~ /subscribe/
      end

      method_names.each do |method_name|
        topic_name = topic_name_for(service, method_name)
        Log.instance.logger.info("Creating topic #{topic_name}")
        RedpandaPort.instance.create_topic(topic_name, 1, 1)
      end
    end
  end

  def start_producers!
    %w[router lightning].each do |service|
      method_names = LND.instance.client.send(service).doc.available_methods.filter do |method_name|
        method_name =~ /subscribe/
      end

      method_names.each do |method_name|
        start_producer_for!(service, method_name)
      end
    end
  end

  def topic_name_for(service, method_name)
    "lnd.#{service}.#{method_name.sub(/^subscribe_/, '')}".gsub('_', '-')
  end

  def start_producer_for!(service, method_name)
    topic_name = topic_name_for(service, method_name)

    Log.instance.logger.info("Starting producer #{topic_name}")

    Thread.new do
      LND.instance.client.send(service).send(method_name) do |data|
        RedpandaPort.instance.produce(topic_name, data)
      end
    end
    @topics << topic_name
  end
end

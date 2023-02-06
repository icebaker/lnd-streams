# frozen_string_literal: true

require 'roda'
require 'rack/cors'

require_relative '../ports/http'

class AppController < Roda
  plugin :json

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: %i[get options head]
    end
  end

  route { |r| HTTP.routes(r, request) }
end

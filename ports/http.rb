# frozen_string_literal: true

require_relative '../controllers/index'

module HTTP
  def self.routes(route, _request)
    route.root do
      IndexController.handler
    end
  end
end

# frozen_string_literal: true

require 'omniauth/potok/version'
require 'omniauth'

module OmniAuth
  module Strategies
    class Error < StandardError; end

    autoload :Potok, 'omniauth/strategies/potok'
  end
end

OmniAuth.config.add_camelization 'potok', 'Potok'

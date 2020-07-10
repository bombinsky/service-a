# frozen_string_literal: true

require 'sneakers'
Sneakers.configure connection: Connection.bunny,
                   daemonize: true,
                   workers: 1,
                   threads: 1,
                   ack: true,
                   env: ENV['RACK_ENV'],
                   heartbeat: 20,
                   exchange: 'sneakers',
                   exchange_type: :direct,
                   log: 'sneakers.log',
                   start_worker_delay: 1

Sneakers.logger = Rails.logger
Sneakers.logger.level = Logger::INFO

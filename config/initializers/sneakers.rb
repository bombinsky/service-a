require 'sneakers'
Sneakers.configure connection: Connection.bunny,
                   daemonize: true,
                   workers: 1,
                   threads: 1,
                   ack: true,
                   env: ENV['RACK_ENV'],
                   heartbeat: 2,
                   exchange: 'sneakers',
                   log: 'sneakers.log',
                   start_worker_delay: 1

Sneakers.logger = Rails.logger
Sneakers.logger.level = Logger::INFO

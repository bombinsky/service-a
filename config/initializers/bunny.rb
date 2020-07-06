module Connection
  def self.bunny
    @_bunny ||= begin
      Bunny.new(
        username:  Treasury.bunny_amqp_user,
        password:  Treasury.bunny_amqp_password,
        addresses: Settings.bunny_amqp_addresses&.split(','),
        automatically_recover: true,
        connection_timeout: 2,
        continuation_timeout: (Settings.bunny_continuation_timeout || 10_000).to_i,
        logger: Rails.logger
      )
    end
  end
end

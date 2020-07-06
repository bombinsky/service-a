class Treasury
  class << self
    def method_missing(m, *args, &block)
      variable_name = m.to_s.upcase
      ENV[variable_name] ||
      File.read("/run/secrets/#{m}").strip ||
      raise("Please provide environmental variable #{ variable_name } or swarm secret #{m} if production env")
    end
  end
end
class Settings
  class << self
    def method_missing(m, *args, &block)
      variable_name = m.to_s.upcase
      ENV[variable_name] || raise("Please provide environmental variable #{variable_name}")
    end
  end
end
require 'ougai'

module ApplicationConfig
  def self.logger
    @logger ||= Ougai::Logger.new(STDOUT)
  end
end

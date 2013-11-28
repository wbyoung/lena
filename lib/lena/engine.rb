require 'lena/rails/routing'

module Lena
  class ClientError < StandardError; end

  class Engine < ::Rails::Engine
    isolate_namespace Lena
    initializer "lena.assets.precompile" do |app|
      app.config.assets.precompile += %w(lena.js)
    end

    config.report_handler = Proc.new do
      raise ClientError.new
    end
  end

  def self.setup
    yield Engine.config
  end
end

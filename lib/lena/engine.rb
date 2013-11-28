require 'lena/rails/routing'

module Lena
  class JavaScriptError < StandardError; end

  class Engine < ::Rails::Engine
    isolate_namespace Lena
    initializer "lena.assets.precompile" do |app|
      app.config.assets.precompile += %w(lena.js)
    end

    config.javascript_handler = Proc.new do
      raise JavaScriptError.new
    end
  end

  def self.setup
    yield Engine.config
  end
end

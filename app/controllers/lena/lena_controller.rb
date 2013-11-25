module Lena
  class LenaController < ActionController::Base
    def log
      Lena::Engine.config.javascript_handler.call params
      render text: ""
    end
  end
end

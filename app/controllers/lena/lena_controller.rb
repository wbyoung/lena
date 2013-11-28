module Lena
  class LenaController < ActionController::Base
    def js
      Lena::Engine.config.javascript_handler.call params
      render text: ""
    end
  end
end

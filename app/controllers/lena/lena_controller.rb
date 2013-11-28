module Lena
  class LenaController < ActionController::Base
    def report
      Lena::Engine.config.report_handler.call params
      render text: ""
    end
  end
end

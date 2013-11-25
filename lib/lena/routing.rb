module Lena
  # Extending the object that's returned from rails routing helpers (for
  # instance +main_app+ or +lena+) that allow calling specific URL helper
  # methods.
  module Routing
    def configuration
      return {
        'data-lena-destination' => Rails.env.development? ? "local" : "",
        'data-lena-url' => self.submission_path,
      }
    end
  end
end

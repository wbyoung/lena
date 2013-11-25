
# For testing, we'll store all events into an array
Lena.class.send(:cattr_accessor, :events)
Lena.events = []

Lena.setup do |config|
  config.javascript_handler = Proc.new do |params|
    Lena.events << params
  end
end

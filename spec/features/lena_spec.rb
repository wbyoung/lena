require 'rails_helper'

describe 'lena test app' do

  context 'with default capture' do
    it 'throws exceptions' do
      expect { visit lena.report_path }.to raise_error(Lena::ClientError)
    end
  end

  context 'with custom capture', js: true do
    before do
      @report_handler = Lena::Engine.config.report_handler
      @events = []
      handler = Proc.new { |params| @events << params }
      Lena.setup { |config| config.report_handler = handler }
    end

    after do
      Lena::Engine.config.report_handler = @report_handler
    end

    it 'includes data attributes' do
      visit root_path
      expect(page.body).to include('data-lena-remote-url')
      expect(page.body).to include('data-lena-destination')
    end

    it 'reports errors for log' do
      expect { visit log_path }.to change { @events.length }.by(1)
      event = @events[-1]
      expect(event[:message]).to eq("Simple error log")
      expect(event[:stacktrace]).to eq("unsupported")
    end

    it 'reports errors for exceptions' do
      expect { visit throw_path }.to change { @events.length }.by(1)
      event = @events[-1]
      expect(event[:message]).to eq("Error: Simple error throw\nResource: undefined:0")
      expect(event[:stacktrace]).to be_nil
    end

    it 'reports errors when nested, but cannot provide stack trace' do
      expect { visit throw_callstack_path }.to change { @events.length }.by(1)
      event = @events[-1]
      expect(event[:message]).to eq("ReferenceError: Can't find variable: undefinedFunctionCall\nResource: undefined:0")
      expect(event[:stacktrace]).to be_nil
    end
  end
end

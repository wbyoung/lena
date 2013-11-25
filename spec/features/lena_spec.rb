require 'spec_helper'

describe 'generating errors', js: true do
  it 'includes data attributes' do
    visit root_path
    expect(page.body).to include('data-lena-url')
    expect(page.body).to include('data-lena-destination')
  end

  it 'reports errors for log' do
    expect { visit log_path }.to change { Lena.events.length }.by(1)
    event = Lena.events[-1]
    expect(event[:message]).to eq("Simple error log")
    expect(event[:stacktrace]).to eq("unsupported")
  end

  it 'reports errors for exceptions' do
    expect { visit throw_path }.to change { Lena.events.length }.by(1)
    event = Lena.events[-1]
    expect(event[:message]).to eq("Error: Simple error throw\nResource: undefined:0")
    expect(event[:stacktrace]).to be_nil
  end

  it 'reports errors when nested, but cannot provide stack trace' do
    expect { visit throw_callstack_path }.to change { Lena.events.length }.by(1)
    event = Lena.events[-1]
    expect(event[:message]).to eq("ReferenceError: Can't find variable: undefinedFunctionCall\nResource: undefined:0")
    expect(event[:stacktrace]).to be_nil
  end
end

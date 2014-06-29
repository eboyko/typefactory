require 'spec_helper'

RSpec.describe 'Typefactory' do
  it 'Successfully sets up configuration' do
    Typefactory.setup do |config|
      config.quotes_marks = [
        { :left => "&laquo;", :right => "&raquo;" },
        { :left => "&bdquo;", :right => "&ldquo;" },
        { :left => "&lsquo;", :right => "&rsquo;" }
      ]

      expect(config.quotes_marks.class).to eq(Array)
    end
  end
end
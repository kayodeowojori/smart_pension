# frozen_string_literal: true

require 'spec_helper.rb'
require './log_processor.rb'

RSpec.describe LogProcessor do
  context 'with no files' do
    it 'raises error' do
      expect { described_class.new.process }.to raise_error(ArgumentError, 'missing keyword: filename')
    end

    it 'raises error when can not read file' do
      expect { described_class.new(filename: 'hello').process }.to raise_error(Errno::ENOENT)
    end
  end

  context 'with valid file specified' do
    let(:subject) do
      described_class.new(filename: 'spec/samples/webserver.log').process
    end

    it 'parses all views correctly' do
      expected_result = ['/about/2 90 visits', '/contact 89 visits', '/index 82 visits', '/about 81 visits', '/help_page/1 80 visits', '/home 78 visits']
      expect(subject[:page_views]).to eq(expected_result)
    end

    it 'raises error' do
      expected_result = ['/about/2 69 unique visits', '/contact 67 unique visits', '/about 61 unique visits', '/index 60 unique visits', '/help_page/1 58 unique visits', '/home 56 unique visits']

      expect(subject[:unique_views]).to eq(expected_result)
    end
  end
end

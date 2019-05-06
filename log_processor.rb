# frozen_string_literal: true

# Simple file which processes a log file
class LogProcessor
  attr_reader :filename

  module LABELS
    REGULAR_VISITS = 'visits'
    UNIQUE_VISITS = 'unique visits'
  end

  FILE_NAME_ERROR = 'Please supply a file'

  def initialize(filename:)
    raise FILE_NAME_ERROR unless filename

    @filename = filename
  end

  def process
    summary = {}
    File.foreach(filename) do |line|
      process_line(line, summary)
    end

    {
      page_views: view_pages(summary),
      unique_views: view_uniq_view(summary)
    }
  end

  private

  def update_existing(page, ip)
    page[:total] = page[:total] + 1
    page[:uniq] = page[:uniq] + 1 if page[:ips].include?(ip)
    page[:ips] << ip unless page[:ips].include?(ip)
  end

  def create_new_entry(summary, pagename, ip)
    summary[pagename] = { total: 1, uniq: 1, ips: [ip] }
  end

  def view_pages(summary)
    summary.sort_by { |_key, value| value[:total] }.reverse.map { |key, value| "#{key} #{value[:total]} #{LABELS::REGULAR_VISITS}" }
  end

  def view_uniq_view(summary)
    summary.sort_by { |_key, value| value[:uniq] }.reverse.map { |key, value| "#{key} #{value[:uniq]} #{LABELS::UNIQUE_VISITS}" }
  end

  def process_line(line, summary)
    pagename, ip = line.split(' ')

    summary[pagename] ? update_existing(summary[pagename], ip) : create_new_entry(summary, pagename, ip)
  end
end

# {
#   pagename: {
#     total: 12,
#     uniq: 3,
#     [{ip: ip}]
#   }
# }

require 'nokogiri'
require 'open-uri'
require 'slack-notifier'

namespace :alerts do
  desc 'Check for state employee alerts'
  task check: :environment do
    notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
    page = Nokogiri::HTML(open('http://www.mass.gov/alert/alertlanding.html'))
    page.css('div.alert_unit').each do |alert|
      time_updated = DateTime.strptime(alert.css('p.alert_meta')
                             .text[/\w+\s\d{2},\s\d{4}\s\d{2}:\d{2}\s(AM|PM)/], '%B %d, %Y %I:%M %p')
      next if Alert.where(updated: time_updated).count > 0
      Alert.create(title: alert.css('h2').text,
                   updated: time_updated,
                   body: alert.css('div.alert_body p').text)
      notifier.ping alert.css('div.alert_body p').text
    end
  end
end

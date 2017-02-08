require 'nokogiri'
require 'open-uri'
require 'slack-notifier'

desc "Check for state employee alerts"
task :check => :environment do
  notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
  page = Nokogiri::HTML(open("http://www.mass.gov/alert/alertlanding.html"))
  page.css('div.alert_unit').each do |alert|
    # check if the alert was already posted
    next if Alert.where(
           :updated => alert.css('p.alert_meta').text).count > 1
    Alert.create(title: alert.css('h2').text, updated: alert.css('p.alert_meta').text, body: alert.css('div.alert_body p').text)
    notifier.ping alert.css('div.alert_body p').text
  end
end

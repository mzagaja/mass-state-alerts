require 'nokogiri'
require 'open-uri'
require 'slack-notifier'

namespace :alerts do
  desc 'Check for state employee alerts'
  task check: :environment do
    notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
    page = Nokogiri::HTML(open('https://www.mass.gov/alerts/winter-weather-alerts'))
    alert_count = page.css('h2.ma__comp-heading').count - 1
    for i in 0..alert_count
      # page.css('h2.ma__comp-heading')[i].text
      # page.css('span.ma__callout-time__text')[i].text
      # page.css('section.ma__rich-text div')[i].text
      time_updated = DateTime.strptime(page.css('span.ma__callout-time__text')[i]
                             .text[/\d{2}.\d{2}.\d{2},\s\d{,2}:\d{,2}\s(am|pm)/], '%m.%d.%y, %I:%M %P')
      next if Alert.where(updated: time_updated).count > 0
      Alert.create(title: page.css('h2.ma__comp-heading')[i].text,
                   updated: time_updated,
                   body: page.css('section.ma__rich-text div')[i].text)
      notifier.ping page.css('section.ma__rich-text div')[i].text
    end
  end
end

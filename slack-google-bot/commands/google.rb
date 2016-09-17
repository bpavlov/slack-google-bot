require 'http'

module SlackGoogleBot
  module Commands
    class Google < SlackRubyBot::Commands::Base
      match(/^(?<bot>\w*)\s(?<expression>.*)$/) do |client, data, match|
        expression = match['expression'].strip
        results = JSON.parse HTTP.get("https://www.googleapis.com/customsearch/v1", params: {
              q: expression,
              key: ENV['GOOGLE_API_KEY'],
              cx: ENV['GOOGLE_CSE_ID']
            })
        if results['items'].nil?
          result = nil
        else
          result = results['items'].first
        end
        if result.nil?
          message = "No search results for `#{expression}`"
        else
          message = result['title'] + "\n" + result['link'] + "\n" + "```" + result['snippet'] + "```"
        end
        send_message client, data.channel, message
      end
    end
  end
end

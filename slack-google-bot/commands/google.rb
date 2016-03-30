module SlackGoogleBot
  module Commands
    class Google < SlackRubyBot::Commands::Base
      match(/^(?<bot>\w*)\s(?<expression>.*)$/) do |client, data, match|
        expression = match['expression'].strip
        query = { query: expression }
        query[:cx] = ENV['GOOGLE_CSE_ID'] if ENV['GOOGLE_CSE_ID']
        result = ::Google::Search::Web.new(query).first
        if result.nil?
          message = "No search results for `#{expression}`"
        else
          message = result.title + "\n" + result.uri + "\n" + "```" + result.content + "```"
        end
        send_message client, data.channel, message
      end
    end
  end
end

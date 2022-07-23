#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/inline'
require 'date'

gemfile do
  source 'https://rubygems.org'
  gem 'notion-ruby-client'
end

module NotionConstants
  PROPERTIES = {
    "title": {
      "title": [
        {
          "text": {
            "content": "日報_#{Date.today.strftime('%Y%m%d')}_"
          }
        }
      ]
    },
    "type": {
      "select": {
        "name": "日報"
      }
    },
    "date": {
      "date": {
        "start": Date.today.strftime('%Y-%m-%d')
      }
    }
  }.freeze
end

class NotionPostman
  include NotionConstants

  def self.create_page
    client = Notion::Client.new(token: ENV['NOTION_API_TOKEN'])
    client.create_page(
      parent: { database_id: ENV['NOTION_DATABASE_ID']},
      properties: NotionConstants::PROPERTIES,
    )
  end
end

NotionPostman.create_page

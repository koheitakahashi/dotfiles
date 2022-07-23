#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler'

class GemInfo
  Gem = Struct.new('Gem', :name, :summary, :repository)

  class << self
    def output
      Bundler.load.lock
      gems = Bundler::Definition.build('Gemfile', nil, nil).requires

      gems_info = build_gem_struct(gems)
      gems_info.each do |gem|
        colorize_print(gem.name, gem.summary, gem.repository)
      end
    end

    private

    def build_gem_struct(gems)
      gems.keys.map do |gem_name|
        gem_info = ::Gem::Specification.find_all_by_name(gem_name).last
        name, summary, homepage = gem_info&.name, gem_info&.summary, gem_info&.homepage

        next unless [name, summary, homepage].all?
        Gem.new(name, summary, homepage)
      end.compact
    end

    def colorize_print(str1, str2, str3)
      puts "Name: \e[1m#{str1}\e[0m"
      puts "Summary: #{str2}"
      puts "URL: \e[35m#{str3}\e[0m\n\n"
    end
  end
end

GemInfo.output

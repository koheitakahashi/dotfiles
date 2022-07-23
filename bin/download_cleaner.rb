#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

class Cleaner
  HOME_DIRECTORY_PATH = ENV.fetch('HOME').freeze

  def self.execute
    new.execute
  end

  def initialize
    @args = (ARGV[0] || "#{HOME_DIRECTORY_PATH}/downloads")
  end

  def execute
    files = fetch_file_paths.map { |path| File.new(path) }
    birth_date_array = files.map { |file| file.birthtime.strftime('%Y%m%d') }.uniq

    make_date_directory(birth_date_array)
    move_files(files, birth_date_array)
  end

  private

  attr_reader :args

  def fetch_file_paths
    return @file_paths if @file_paths

    file_paths = Dir.glob('*', base: args).map do |file_name|
      # 作成される 20200616 などの日付のディレクトリ以外のファイル or ディレクトリのパスを返す
      target_path(file_name).to_s unless file_name.match?(/^20[0-9]{6}$/)
    end

    @file_paths = file_paths.compact
  end

  def move_files(files, birth_date_array)
    files.each do |file|
      move_directory_name = birth_date_array.select { |date| date == file.birthtime.strftime('%Y%m%d') }.first
      FileUtils.mv(file.path, "#{target_path(move_directory_name)}/") if move_directory_name

      puts "#{file.path} moved to #{target_path(move_directory_name)}/"
    end
  end

  def make_date_directory(birth_date_array)
    birth_date_array.each do |date|
      Dir.mkdir(target_path(date).to_s, 0o755) unless Dir.exist?(target_path(date).to_s)
    end
  end

  def target_path(path)
    "#{args}/#{path}"
  end
end

Cleaner.execute

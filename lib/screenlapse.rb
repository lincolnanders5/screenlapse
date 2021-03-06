# frozen_string_literal: true
require "fileutils"
require "pathname"
require "streamio-ffmpeg"

require_relative "screenlapse/version"

module Screenlapse
  class Error < StandardError; end

  def video_path
    "#{archive_path}/render/#{Time.now.strftime("%m-%d-%H-%M")}.mp4"
  end

  def render_video(fps=6)
    system "ffmpeg -hide_banner -loglevel error -r #{fps} -f 'image2' -s 1920x1080 -i \"#{archive_path}/#{datefmt}/%05d.png\" -vcodec libx264 -crf 25 -pix_fmt yuv420p \"#{video_path}\""
  end

  def image_diff?(threshold=1000, downsample=4)
    res = system "perceptualdiff -threshold #{threshold} -downsample #{downsample} #{last_capture} #{next_capture} > /dev/null 2>&1"
    return !res
  end

  def next_capture
    "#{archive_path}/#{datefmt}/#{next_capture_num}.png"
  end

  def last_capture
    Dir.glob("#{archive_path}/#{datefmt}/*.png").max_by {|f| File.basename(f, ".*").to_i }
  end

  def next_capture_num
    int = 1
    int = File.basename(last_capture, ".*").to_i + 1 unless last_capture.nil?
    int.to_s.rjust(5, "0")
  end

  def init_dir(path)
    FileUtils.mkdir_p path unless File.exist?(path) && File.directory?(path)
  end

  def archive_path(root: ".")
    root = options[:root] unless options[:root].nil?
    File.expand_path root + "/.scarchive/"
  end

  def datefmt
    Time.now.strftime("%m/%d")
  end

  def movie_list
    Dir.glob(".scarchive/render/*.mp4")
       .sort_by{ |f| File.mtime(f) }.reverse
  end
end

require 'launchy'

module Giphy
  class CLI
    def self.run(keyword)
      new(keyword).search
    end

    def initialize(keyword)
      @keyword = keyword
    end

    def search
      gif_url = result.image_original_url rescue nil

      if gif_url
        puts gif_url
      else
        puts "Unable to find gif for: '#{search}'"
      end
    end

    private

    attr_reader :keyword

    def url
      @url ||= URI("http://giphy.com/embed/#{result.id}")
    end

    def result
      Giphy.random(keyword)
    rescue Giphy::Errors::API
      GifNotFound.new('YyKPbc5OOTSQE')
    end
  end

  GifNotFound = Struct.new(:id)
end

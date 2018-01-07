class Post
    def initialize(thumbnail, title, kind, date, href, image, text)
        @thumbnail = thumbnail
        @title = title
        @kind = kind
        @date = date
        @href = href
        @image = image
        @text = text
    end

    attr_accessor :thumbnail
    attr_accessor :title
    attr_accessor :kind
    attr_accessor :date
    attr_accessor :href
    attr_accessor :image
    attr_accessor :text
end

class FeedController < ApplicationController
    def show
        @posts = Array.new

        jsonPosts = JSON.parse(File.read(Rails.root + "app/assets/javascripts/contents.json"))
        jsonPosts.each do |jsonPost|
            @posts.push(OpenStruct.new(jsonPost))
        end

        render template: "feed/feed"
    end
end

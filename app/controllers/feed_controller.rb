class Post
    def initialize(thumbnail, title, kind, languages, date, href, image, text)
        @thumbnail = thumbnail
        @title = title
        @kind = kind
        @languages = languages
        @date = date
        @href = href
        @image = image
        @text = text
        puts @text
    end

    attr_accessor :thumbnail
    attr_accessor :title
    attr_accessor :kind
    attr_accessor :languages
    attr_accessor :date
    attr_accessor :href
    attr_accessor :image
    attr_accessor :text
end

class FeedController < ApplicationController
    def show
        jsonAbout = JSON.parse(File.read(Rails.root + "app/assets/javascripts/about.json"))
        jsonPosts = JSON.parse(File.read(Rails.root + "app/assets/javascripts/contents.json"))

        @about = Post.new("", jsonAbout["title"], "", "", "", "", "", jsonAbout["text"])
        @posts = Array.new

        jsonPosts.each do |jsonPost|
            @posts.push(Post.new(
                jsonPost["thumbnail"], 
                jsonPost["title"],
                jsonPost["kind"],
                jsonPost["languages"],
                jsonPost["date"],
                jsonPost["href"],
                jsonPost["image"],
                jsonPost["text"]
            ))
        end

        render template: "feed/feed"
    end
end

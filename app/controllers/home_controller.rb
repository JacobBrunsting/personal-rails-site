class Line
    def initialize(text, isListItem)
        @text = text
        @isListItem = isListItem
    end

    def text
        @text
    end

    def isListItem
        @isListItem
    end
end

class SplitLine
    def initialize(sections, isListItem)
        @sections = sections
        @isListItem = isListItem
    end

    def sections
        @sections
    end

    def isListItem
        @isListItem
    end
end

class HomeController < ApplicationController
    helper_method :style
    LINE_WIDTH = 60
    SECTION_WIDTH = 1
    LINE_COUNT = 10

    def show
        lines = [
            Line.new("Works at some place with some stuff and things", false),
            Line.new("> Jacob Brunsting", true),
            Line.new("> Hosssme", true), 
            Line.new("> about_me", true),
            Line.new("> Projects", true),
            Line.new("Workse place with stuff and things", false),
            Line.new("Works at some with stuff and things", false),
            Line.new("Also doese at some place with some stuff and things", false),
            Line.new("Works at some place with some stuff and things", false),
            Line.new(" ", false),
        ]
        @splitLines = Array.new
        lines.each do |line|
            splitLine = Array.new
            section = ""
            line.text.each_char do |c|
                section = section + c
                if section.length >= SECTION_WIDTH
                    splitLine.push(section)
                    section = ""
                end
            end
            if section.length > 0
                splitLine.push(section)
            end
            @splitLines.push(SplitLine.new(splitLine, line.isListItem))
        end
        render template: "home/home"
    end

    def style(lineNum, sectionNum)
        sectionCount = LINE_WIDTH / SECTION_WIDTH
        distFromCenterX = sectionCount / 2 - sectionNum
        distFromCenterY = LINE_COUNT / 2 - lineNum

        scaleX = 1
        if distFromCenterX.abs > 8
            scaleX = 1.0 - ((distFromCenterX.abs ** 2 - 8.0) / 2500.0)
        end
        translateY = (distFromCenterX.abs / 70.0) ** 2.5 * distFromCenterY
        rotate = translateY * 7.0
        if distFromCenterX > 0
            rotate *= -1
        end
        transformSection = "transform: scaleX(%f) translateY(%fvw) rotate(%ddeg)" % [scaleX, translateY, rotate]

        widthSection = ""
        width = scaleX * 1
        widthSection = "width: %fvw" % width
        
        transformSection + "; " + widthSection
    end
end

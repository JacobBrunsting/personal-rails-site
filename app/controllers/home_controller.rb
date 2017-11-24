class Line
    def initialize(text, isListItem=false, href='')
        @text = text
        @isListItem = isListItem
        @href = href
    end

    def text
        @text
    end

    def isListItem
        @isListItem
    end

    def href
        @href
    end
end

class SplitLine
    def initialize(sections, isListItem, href)
        @sections = sections
        @isListItem = isListItem
        @href = href
    end

    def sections
        @sections
    end

    def isListItem
        @isListItem
    end

    def href
        @href
    end
end

class HomeController < ApplicationController
    helper_method :style
    LINE_WIDTH = 60
    SECTION_WIDTH = 1
    LINE_COUNT = 10

    def show
        case params[:page]
        when "about"
            lines = [
                Line.new("About Me"),
                Line.new("> Computer Science student at the University of Waterloo"),
                Line.new("> Interned at several companies, developing mobile apps,"),
                Line.new("  websites, and distributed systems"),
                Line.new("> Interested in full-stack and backend positions"),
                Line.new("> Most experienced in Go, Java, and Javascript"),
                Line.new("  (Node.js/React)"),
                Line.new("> Some experience with Haskell, Ruby on Rails, C++, Python"),
                Line.new(""),
                Line.new("< Back", true, "/home"),
            ]
        when "work"
            lines = [
                Line.new("Work Experience"),
                Line.new("Yahoo (2017)"),
                Line.new("> Worked on a small team to create a new system for tracking"),
                Line.new("usage of internal services (Go, Python)"),
                Line.new("Tribalscale (2017)"),
                Line.new("> Pair programmed, working on a major Android app (Java)"),
                Line.new("> Created the next version of TribalScale.com (Node.js/React)"),
                Line.new("WeMesh (2016)"),
                Line.new("> Developed the Rave Android app (Java)"), 
                Line.new("< Back", true, "/home"),
            ]
        when "projects"
            lines = [
                Line.new("Projects"),
                Line.new("> About me", true, "/about"),
                Line.new("> Work experience", true, "/work"), 
                Line.new("> Projects", true, "/projects"),
                Line.new(""),
                Line.new(""),
                Line.new(""),
                Line.new(""),
                Line.new(""),
                Line.new("< Back", true, "/home"),
            ]
        else 
            lines = [
                Line.new("Welcome to my personal website!"),
                Line.new("> About Me", true, "/about"),
                Line.new("> Work Experience", true, "/work"), 
                Line.new("> Projects", true, "/projects"),
                Line.new(""),
                Line.new(""),
                Line.new(""),
                Line.new(""),
                Line.new(""),
                Line.new(""),
            ]
        end
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
            @splitLines.push(SplitLine.new(splitLine, line.isListItem, line.href))
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

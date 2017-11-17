class HomeController < ApplicationController
    helper_method :style
    LINE_WIDTH = 85
    SECTION_WIDTH = 5

    def show
        lines = [
            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            "Jacob_Brunsting",
            "Hosssme", 
            "about_me"]
        @lines = Array.new
        lines.each do |line|
            splitLine = Array.new
            section = ""
            line.each_char do |c|
                section = section + c
                if section.length >= SECTION_WIDTH
                    splitLine.push(section)
                    section = ""
                end
            end
            if section.length > 0
                splitLine.push(section)
            end
            @lines.push(splitLine)
        end
        render template: "home/home"
    end

    def style(sectionIndex)
        sectionCount = LINE_WIDTH / SECTION_WIDTH
        distFromCenter = sectionCount / 2 - sectionIndex

        transformOrigin = "right"
        if distFromCenter < 0
            transformOrigin = "left"
        end

        scaleX = 1.0
        if distFromCenter.abs > 4
            scaleX = 1.0 - ((distFromCenter.abs - 4.0) / 8.0)
        end
        
        # wow, a switch case of magic numbers with more magic inside!
        translateX = 0.0
        case distFromCenter.abs
        when 8
            translateX = 5.2
        when 7
            translateX = 2.1
        when 6
            translateX = 0.6
        end
        if distFromCenter < 0
            translateX *= -1
        end

        "transform: scaleX(%f) translateX(%fvw); transform-origin: %s" % [scaleX, translateX, transformOrigin]
    end
end

module HomeHelper
    def conditional_link(options={}, &block)
        if options.delete(:show_link)
            concat content_tag(:a, capture(&block), options)
        else
            concat capture(&block)
        end
    end
end

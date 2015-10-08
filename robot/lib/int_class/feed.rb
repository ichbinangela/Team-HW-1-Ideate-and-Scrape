

class Feed

    attr_accessor :title, :author, :date, :tags, :link

    def initialize( title, author, date, tags, link )
        @title = title
        @author = author
        @date = date
        @tags = tags
        @link = link
    end

end

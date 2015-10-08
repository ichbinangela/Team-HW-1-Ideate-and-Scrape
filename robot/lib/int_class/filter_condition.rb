

class FilterCondition

    attr_accessor :conds

    def initialize()
        @conds = Hash.new( false )
    end

    def date_must_before( date )
        @conds[ "date_must_before" ] = date
        self
    end

    def date_must_after( date )
        @conds[ "date_must_after" ] = date
        self
    end

    def tags_must_include( tags )
        @conds[ "tags_must_include" ] = tags
        self
    end

    def tags_must_exclude( tags )
        @conds[ "tags_must_exclude" ] = tags
        self
    end

    def title_must_include( terms )
        @conds[ "title_must_include" ] = terms
        self
    end

    def designated_authors( authors )
        @conds[ "designated_authors" ] = authors
        self
    end

end

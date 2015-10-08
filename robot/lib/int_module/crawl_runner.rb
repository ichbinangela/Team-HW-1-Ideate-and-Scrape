require 'open-uri'
require 'oga'

module Crawler

    attr_accessor :cats, :web_data

    def load_page( url )
        begin
            @web_data = open( url )
            1
        rescue
            0
        end
    end

    def analyze
        raise NotImplementedError.new("#{self.class.name}#analyze is an abstract method.")
    end

    def get_feeds( cat, max_num )
        raise NotImplementedError.new("#{self.class.name}#get_feeds is an abstract method.")
    end

end

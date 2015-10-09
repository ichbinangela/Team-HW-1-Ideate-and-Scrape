require 'open-uri'

module Crawler

    attr_accessor :cats, :web_data, :domain

    def load_page( url )
        begin
            @domain = url
            @domain += "/" unless @domain.end_with? "/"
            open( url ) { |f| @web_data = f.read }
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

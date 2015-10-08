require "open-uri"
require "oga"
require "fileutils"

domains = [
    "bnext.com.tw",
    "inside.com.tw",
    "managertoday.com.tw",
    "thenewslens.com"
]

uri_template = "http://www.{PLACEMENT}/"
file_dir = "mainpage"

FileUtils.mkdir_p( file_dir )

uris = domains.map { |d| uri_template.split( "{PLACEMENT}" ).join( d ) }
file_names = domains.map { |d| [ file_dir, (d.gsub( /\.com[\.tw]*/, "" ) + "_mainpage.html") ].join( "/" ) }

web_files = uris.map do |uri|
        begin
            open(uri).read
        rescue SocketError 
            ""
        end
    end 
    
web_files = file_names.zip( web_files )

web_files.map { |name, file_str| File.open( name, "w" ).write( file_str ) }

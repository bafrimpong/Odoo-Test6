require 'nokogiri' 
require 'httparty'
require 'pry'

# global variables
@regXpattern = /(SAP)/  # regular expression to match the partern
@replaceWith = "Odoo" # the word to replace SAP when found in the webpage
@findFor = "SAP"

def odoo_scraper
    
    # define the URL to scrap from
    url = "https://www.sap.com/belgique/indeswapSAPwithOdoo_page.html"

    # retrieve the unparsed page (the raw page)
    # raw_page = JSON.parse(HTTParty.get(url).body)
    response_page = HTTParty.get(url)
    
    if response_page.code == 200
        puts "Web page successfully reached and downloaded"
    else
        puts "Sorry! The link cannot be reached.\nCheck your webpage address and try again"
    end
 
    # loop through the whole page and search for the word SAP
    swapSAPwithOdoo_page = response_page

    # bis = "I am for peace but when I SAP they are for war!"

    # check if there is a match for the word SAP
    if isWordSAP?(swapSAPwithOdoo_page)

        puts "Nice! There is a for #{@findFor} and will be replaced with #{@replaceWith}"
        swapSAPwithOdoo_page.to_s.gsub!(@regXpattern, @replaceWith)
    end
    
    # now the new page will be saved as html or csv
    # create the file with a name andd give it a write access
    newHTMLPage = File.new("sap-to-odoo.html", "w+")

    # now write to the file
    newHTMLPage.puts swapSAPwithOdoo_page

    # close the file
    newHTMLPage.close()

    # show a message of a successful task completion
    puts "All task completed successfully!"
    
    binding.pry
end

# this method checks if a string passed to it match the word SAP
# and returns true if there is match or false if not
private def isWordSAP?(word_to_find)  

    if word_to_find.match?(@regXpattern)
        return true
    else
        return false
    end
end

odoo_scraper
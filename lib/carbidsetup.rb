require "carbidsetup/version"
require 'highline'
module Carbidsetup
  class Main < HighLine
    def run 
      project_name = ""
      if project_name 
        say("Setting up files for project #{project_name}")
      else
        say("Couldn't find *.xcproject file. Please cd into the correct folder of the project file")
        abort
      end 
      
      info_plist = File.open('./#{project_name}/info.plist')
      info_plist_xml = Nokogiri.xml(info_plist)
      
      choose do |menu|
        menu.prompt = "Tab or drawer menu ?"
        menu.choice(:tab) { cli.say(" Do nothing ") }
        menu.choice(:drawer) { cli.say(" Add slide menu controller swift to podfile ")}
        menu.default = :tab
      end 
      
      choose do |menu|
        menu.prompt = "Authentication with facebook ?"
        menu.choice(:yes) { cli.say("Setting up facebook login") }
        menu.choice(:no) { cli.say("To the next question")}
        menu.default = :yes
      end 
      
      choose do |menu|
        menu.prompt = "Authentication with google ?"
        menu.choice(:yes) { cli.say("Setting up google sign in ")}
        menu.choice(:no) { cli.say("To the next question") }
        menu.default = :yes
      end 
      
      puts "Running pod install"
    end 
  end 
end 

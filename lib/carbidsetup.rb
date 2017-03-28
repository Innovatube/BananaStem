require "carbidsetup/version"
require 'highline'
module Carbidsetup
  class Main < HighLine
    def run 
      project_path = Dir.glob('./*.xcodeproj').first
      if project_path
        say("Setting up files for project #{project_path}")
      else
        say("Couldn't find *.xcproject file. Please cd into the correct folder of the project file")
        abort
      end 
      podfile_path = Dir.glob('./podfile').first
      unless podfile_path
        say("Couldn't find podfile. Please pod init first before running this")
      end 
      
      project_name = project_path.split('.').first
      
      info_plist_path = File.open('./#{project_name}/info.plist')
      info_plist = Nokogiri.xml(info_plist)
      podfile = File.open(podfile_path)
      
      puts '#{podfile}'
      puts '#{info_plist}'

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

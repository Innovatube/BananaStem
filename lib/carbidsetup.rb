require "carbidsetup/version"
require 'highline'
require 'cocoapods'
module Carbidsetup
  class Main < HighLine
    attr_accessor :pods
    attr_accessor :info_plist_path
    def run 
      
      if file_exist? '*.yaml'
        filename = Dir.glob("*.yaml").first 
        `swagger-codegen generate -i #{filename} -l swift3 -o .`
      else 
        puts "swagger file is missing. Please provide."
        abort 
      end 
      #TODO : continue from here. Start asking question
      
      
      add_line_under_line("podfile",/use_frameworks!/, pods_to_string)
      # `pod install` Trying to run pod install 
    end
    
    def login_view_options
      choose do |menu| 
        menu.prompt = "Add login view ?"
        menu.choice(:yes) { 
        login_view_options 
      }
      menu.choice(:no) { 
      # continue on other question 
    }
  end 
end 

def cache_option 
  choose do |menu| 
    menu.prompt = "Add cache options ? "
    menu.choice(:yes) { 
    # run cache command 
  }
  menu.choice(:no)
  menu.default = :yes
end 
end 
def drawer_options  
  choose do |menu|
    menu.prompt = "Add drawer menu ?"
    menu.choice(:yes) { @pods << "SlideMenuControllerSwift" }
    menu.choice(:no) { puts(" Do nothing and continue")}
    menu.default = :no
  end 
end 

def google_option
  choose do |menu|
    menu.prompt = "Authentication with google ?"
    menu.choice(:yes) { setup_google }
    menu.choice(:no) { say "To the next question" }
    menu.default = :yes
  end 
end 

def facebook_option
  choose do |menu|
    menu.prompt = "Authentication with facebook ?"
    menu.choice(:yes) { setup_facebook }
    menu.choice(:no) { say "To the next question"}
  end 
end  

def file_exist?(file_ext)
  Dir.glob(file_ext).first
end
end 
end
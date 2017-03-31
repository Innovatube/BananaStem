require "carbidsetup/version"
require 'highline'
require "carbidsetup/command/loginscreen"
require "carbidsetup/command/listscreen"
require "carbidsetup/command/facebooksetup"
require "carbidsetup/command/googlesetup"
module Carbidsetup
  class Main < HighLine
    def run 
      puts "Making sure I can change this file"
      if file_exist? '*.yaml'
        filename = Dir.glob("*.yaml").first 
        `swagger-codegen generate -i #{filename} -l swift3 -o .`
      else 
        puts "swagger file is missing. Please provide."
        # abort 
      end 
      cache_option
      login_view_options
      list_view_options
    end 
    
    
    def login_view_options
      choose do |menu| 
        menu.prompt = "Add login view ?"
        menu.choice(:yes)
        menu.choice(:no) { return }
      end 
      choose do |menu|
        menu.prompt = "Additional authentication options ?"
        menu.choice(:facebook_google)
        menu.choice(:facebook) 
        menu.choice(:google)
        menu.choice(:no) { return }
        menu.default = :no
      end 
    end 
    
    def cache_option 
      choose do |menu| 
        menu.prompt = "Add cache options ? "
        menu.choice(:yes) 
        menu.choice(:no)
        menu.default = :yes
      end 
    end 
    
    def list_view_options  
      choose do |menu|
        menu.prompt = "Add list view ?"
        menu.choice(:yes) 
        menu.choice(:no) { return }
        menu.default = :yes 
      end 
      
      choose do |menu|
        menu.prompt = "Add drawer menu ?"
        menu.choice(:yes) { @pods << "SlideMenuControllerSwift" }
        menu.choice(:no) { return }
        menu.default = :no
      end 
    end 
    
    def file_exist?(file_ext)
      Dir.glob(file_ext).first
    end

  end 
end
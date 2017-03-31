require "carbidsetup/version"
require 'highline'
require "carbidsetup/command/loginscreen"
require "carbidsetup/command/listscreen"
require "carbidsetup/command/facebooksetup"
require "carbidsetup/command/googlesetup"
module Carbidsetup
  class Main < HighLine
    attr_accessor :project_name
    def run 
    #   unless file_exist? '*.yaml'
    #     puts "Swagger file is missing. Please provide."
    #     abort 
    #   end 
    #   @project_name = ask("Choose a project name") { |q| q.default = "TestProject" }
    # FileUtils.mkdir("./#{@project_name}")
    #   filename = Dir.glob("*.yaml").first 
    #   `swagger-codegen generate -i #{filename} -l swift3 -o ./#{project_name}/swagger` 
    #   cache_option
    @project_name = "ABC"
      login_view_options
      list_view_options
    # `pod install` Trying to run pod install 
    end
    
    def login_view_options
      options = Hash.new
      choose do |menu| 
        menu.prompt = "   Add login view ?"
        menu.choice(:yes)
        menu.choice(:no) { return }
      end 
      choose do |menu|
        menu.prompt = "   Additional authentication options ?"
        menu.choice(:facebook_google) { options["authentication"] = "facebook_google" }
        menu.choice(:facebook) { options["authentication"] = "facebook" }
        menu.choice(:google) { options["authentication"] = "google" }
        menu.choice(:no) { options["authentication"] = "" }
        menu.default = :no
      end 
      Carbidsetup::Loginscreen.new(@project_name, options).run
    end 
    
    def cache_option 
      choose do |menu| 
        menu.prompt = "   Add cache options ? "
        menu.choice(:yes) 
        menu.choice(:no)
        menu.default = :yes
      end
    end 
    
    def list_view_options
      options = Hash.new
      choose do |menu|
        menu.prompt = "   Add list view ?"
        menu.choice(:yes) 
        menu.choice(:no) { return }
        menu.default = :yes 
      end 
      
      choose do |menu|
        menu.prompt = "   Add drawer menu ?"
        menu.choice(:yes) { options["drawer"] = true }
        menu.choice(:no)
        menu.default = :no
      end 
      # Add list view
    end 
    
    def file_exist?(file_ext)
      Dir.glob(file_ext).first
    end
    
    
  end 
end
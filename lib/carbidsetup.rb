require "carbidsetup/version"
require 'highline'
require "carbidsetup/command/loginscreen"
require "carbidsetup/command/listscreen"
require "carbidsetup/command/facebooksetup"
require "carbidsetup/command/googlesetup"
require "carbidsetup/command/iosproject"

module Carbidsetup
  class Main < HighLine
    attr_accessor :project_name
    def run 
      unless File.exist? '*.yaml'
        puts "Swagger file is missing. Please provide."
        abort 
      end 
      setup_xcode_project
      filename = Dir.glob("*.yaml").first 
      `swagger-codegen generate -i #{filename} -l swift3 -o ./#{project_name}/swagger` 
      login_view_options
      list_view_options
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
      Listscreen.new(@project_name, options).run
    end 

    def setup_xcode_project
      options = Hash.new
      @project_name = ask("Choose a project name") { |q| q.default = "TestProject" }
      Carbidsetup::IOSProject.new(@project_name, options).run
    end

  end 
end
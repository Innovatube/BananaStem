require "carbidsetup/version"
require 'highline'
require "carbidsetup/command/loginscreen"
require "carbidsetup/command/listscreen"
require "carbidsetup/command/facebooksetup"
require "carbidsetup/command/googlesetup"
require "carbidsetup/command/iosproject"
require "carbidsetup/user_interface"

module Carbidsetup
  class CarbidsetupError < StandardError; end 
  class Main < HighLine
    attr_accessor :project_name

    def run 
      swagger
      setup_xcode_project
      login_view_options
      list_view_options
      UserInterface.prints_warnings
    end

    def brew_package_exist?(name)
      system "brew ls --versions #{name}"
    end 

    def check_swagger_codegen 
      unless brew_package_exist? "swagger-codegen-moya"
        UserInterface.notice "Missing brew package swagger-codegen-moya"
        UserInterface.notice "Install brew package swagger-codegen-moya"
        `brew install https://raw.githubusercontent.com/dangthaison91/swagger-codegen-moya/swift3_moya/swagger-codegen-moya.rb`
      end
    end 

    def swagger
      unless File.exist? '*.yaml'
        UserInterface.warn "Swagger file is missing. Please provide."
        UserInterface.warn "Won't check nor run swagger-codegen as a result."
        return 
      end 
      filename = Dir.glob("*.yaml").first 
      check_swagger_codegen
      `swagger-codegen generate -t swagger/moya-template -i #{filename} -l swift3-moya -c ./bin/swagger-config.json -o ./#{project_name}/API`
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
      # Loginscreen.new(@project_name, options).run
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
      # Listscreen.new(@project_name, options).run
    end 

    def ask_check_project
      count = 0 
      begin 
        puts "Directory with the same name existed." if count > 0  
        @project_name = ask("Choose a project name") { |q| q.default = "TestProject" }
        count += 1 
      end until !File.directory? @project_name
    end 
    
    def setup_xcode_project
      options = Hash.new
      ask_check_project
      # IOSProject.new(@project_name, options).run
    end
    
  end 
end
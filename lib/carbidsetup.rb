require "carbidsetup/version"
require 'highline'
require 'pathname'
require 'find'

require "carbidsetup/command/loginscreen"
require "carbidsetup/command/listscreen"
require "carbidsetup/command/facebooksetup"
require "carbidsetup/command/googlesetup"
require "carbidsetup/command/iosproject"
require "carbidsetup/user_interface"
require "carbidsetup/xcodeproj"

module Carbidsetup
  class CarbidsetupError < StandardError; end 
  class Main < HighLine
    attr_accessor :project_name
    
    BOILERPLATE_GIT_URL = 'https://github.com/Innovatube/ios-clean-boilerplate.git'
    BOILERPLATE_MAIN_GROUP = 'CleanBoilerplate'

    def run 
      swagger
      setup_xcode_project
      main_project = download_boilerplate
      download_and_add main_project, 'https://github.com/SimplicityMobile/Simplicity.git' 
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
      # `swagger-codegen generate -t swagger/moya-template -i #{filename} -l swift3-moya -c ./bin/swagger-config.json -o ./#{project_name}/API`
      `swagger-codegen generate -i #{filename} -l swift3 -o ./#{project_name}/API`
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
    
    def download_boilerplate
      UserInterface.notice 'Make sure you have read access to Innovatube\'s Github repo'
      Git.download_git_master BOILERPLATE_GIT_URL
      Xcodeproj::Project.main_project(Git.repo_name BOILERPLATE_GIT_URL)
    end 
    
    def download_and_add(main_project, url)
      project = main_project[BOILERPLATE_MAIN_GROUP]
      folder_name = Git.repo_name(url)
      Git.download_git_master(url, File.join(main_project.path.dirname,BOILERPLATE_MAIN_GROUP, Git.repo_name(url)))
      Find.find(File.join(main_project.path.dirname,BOILERPLATE_MAIN_GROUP, folder_name)) do |path|
        # Use the .new_file method allow both project / group in project to add file
        project.new_file(path) if path =~ /.*\.swift$/
      end
      main_project.save
    end
    
  end 
end
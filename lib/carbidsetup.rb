require "carbidsetup/version"
require 'pathname'
require 'find'

require "carbidsetup/git"
require "carbidsetup/command/facebooksetup"
require "carbidsetup/command/googlesetup"
require "carbidsetup/user_interface"
require "carbidsetup/xcodeproj"

module Carbidsetup
  class CarbidsetupError < StandardError; end 
  class Main
    attr_accessor :project_name
    attr_accessor :options 
    BOILERPLATE_GIT_URL = 'https://github.com/Innovatube/ios-clean-boilerplate.git'
    BOILERPLATE_MAIN_GROUP = 'CleanBoilerplate'
    
    def run(options = ARGV)
      @options = options
      unless options.nil? 
        options.each do |option| 
          if Carbidsetup::Git.git_url_isValid? option 
            download_and_add Xcodeproj::Project.main_project('.'), option 
          else 
            download_and_add Xcodeproj::Project.main_project('.'), "https://github.com/Innovatube/#{option}.git"
          end 
        end 
      else 
        setup_new_project 
      end 
    end
    
    def setup_new_project 
      swagger
      main_project = download_boilerplate
      download_and_add main_project, 'https://github.com/doraeminemon/AuthBoilerplateServiceMoya.git' 
      UserInterface.prints_warnings
    end 
    
    
    def brew_package_exist?(name)
      system "brew ls --versions #{name}"
    end 
    
    def check_swagger_codegen 
      unless brew_package_exist? "swagger-codegen-moya"
        UserInterface.notice "Install missing brew package swagger-codegen-moya"
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
    
    def download_boilerplate
      UserInterface.notice 'Make sure you have read access to Innovatube\'s Github repo'
      Git.download_git_master BOILERPLATE_GIT_URL
      Xcodeproj::Project.main_project(Git.repo_name BOILERPLATE_GIT_URL)
    end 
    
    def download_and_add(main_project, url)
      folder_name = Git.repo_name(url)
      project_folder = main_project.path.dirname
      dependency_path = File.join project_folder,BOILERPLATE_MAIN_GROUP, folder_name
      project = main_project[BOILERPLATE_MAIN_GROUP].new_group folder_name
      Git.download_git_master(url, dependency_path)
      Find.find(dependency_path) do |path|
        project.new_file(path) if path =~ /.*\.swift$/
      end
      main_project.save
    end
    
  end 
end
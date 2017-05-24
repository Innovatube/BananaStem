require 'xcodeproj'
require 'carbidsetup'
module Xcodeproj
    class Project
        class << self 
            def main_project(path)
                Project.open(Project.project_path_in_directory(path))
            end 
            
            def project_path_in_directory(path)
                result = Dir.glob(File.join(path,'*.xcodeproj')).first 
                raise Carbidsetup::CarbidsetupError, "Project file missing in #{path}" if result.nil? 
                result
            end 
        end 
    end 
end 
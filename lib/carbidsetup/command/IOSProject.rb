require "fileutils"
require "nokogiri"
require "carbidsetup/command"
require "carbidsetup/git"

module Carbidsetup
    class IOSProject < Command

        IOS_RAW_PROJECT = "../lib/carbidsetup/template_files/raw_project/iOS_Raw_Project/"
        RAW_PROJECT_NAME = "Raw-Project"
        XCODEPROJ = ".xcodeproj"
        PROJECT_XCWORKSPACE = "/project.xcworkspace"
        CONTENT_XCWORKSPACEDATA = "/contents.xcworkspacedata"
        FILE_REF = "FileRef"
        PBXPROJ_FILE = "/project.pbxproj"

        def run
            Git.archive_raw_ios_project(project_destination)
            make_usage_project
        end

        def make_usage_project
            # Rename folder to project name
            FileUtils.mv @project_name + "/" + RAW_PROJECT_NAME , @project_name + "/" + @project_name
            FileUtils.mv @project_name + "/" + RAW_PROJECT_NAME + XCODEPROJ, @project_name + "/" + @project_name + XCODEPROJ

            # Change contents.xcworkspacedata.
            project_file = "/" + @project_name + XCODEPROJ
            contents_file = @project_name + project_file + PROJECT_XCWORKSPACE + CONTENT_XCWORKSPACEDATA
            contents = Nokogiri::XML(File.read(contents_file))
            # Change content of "FileRef" attribute
            file_refs = contents.at_css FILE_REF
            file_refs["location"] = "self:" + @project_name + XCODEPROJ
            File.write(contents_file, contents.to_xml)
            # Change project.pbxproj
            pbxproj_file = @project_name + project_file + PBXPROJ_FILE
            text = File.read(pbxproj_file)
            content = text.gsub(RAW_PROJECT_NAME, @project_name)
            File.open(pbxproj_file, "w") { |file| file << content }
        end        
    end
end
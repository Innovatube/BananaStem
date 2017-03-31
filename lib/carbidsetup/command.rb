require 'carbidsetup/util/file_edit'
module Carbidsetup
    class Command
        def initialize(project_name, *options)
            @project_name = project_name
            @options = options
        end 

        def add_pod(pod)
            unless Dir.grep("podfile").first 
                `echo #{podfile_content} > podfile`
            end 
            file = FileEdit("podfile")
            file.insert_line_after_match(/use_frameworks!/, pod)
            file.write_file
        end
        
        def add_url_scheme(url)
            plist_path = "#{project_name}/info.plist"
            unless Dir.grep(plist_path)
                `echo #{info_plist_content} > #{plist_path}`
            end
            file = FileEdit(plist_path)
            file.insert_line_after_match(url_scheme_xml_matcher,
            "<dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
            <string>#{url}</string>
            </array>
            </dict>
            " 
            )
            # if !line_exist_in_file?(@info_plist_path, )
            #   add_line_under_line(@info_plist_path,/<dict>/, "<key>CFBundleURLTypes</key>
            #   ") 
            # end
            
            # add_line_under_line(@info_plist_path, /\A<key>CFBundleURLTypes<\/key>\z/,
            )
        end
        
        def project_destination 
            "./Project_folder/"
        end
        
        def podfile_content 
            "target #{@project_name} do 
                dynamic framework 
                use_frameworks!
            end"
        end 

        def info_plist_content 
            "<dict>/n<key>CFBundleURLTypes</key>/n</dict>"
        end

        def url_scheme_xml_matcher 
            /\A<key>CFBundleURLTypes<\/key>\z/
        end 
        
    end 
end 
require 'carbidsetup/util/file_edit'
module Carbidsetup
    class Command
        def initialize(project_name, options)
            @project_name = project_name
            @options = options
        end 

        def add_pod(pod)
            unless File.exist?("#{project_destination}podfile")
                File.open("#{project_destination}/podfile", "w+") do |file |
                    file.puts podfile_content
                end 
            end 
            file = FileEdit.new("#{project_destination}podfile")
            file.insert_line_after_match(/use_frameworks!/, "pod  " + pod )
            file.write_file
        end
        
        def add_url_scheme(url)
            plist_path = "#{project_name}/info.plist"
            unless Dir.glob(plist_path).first 
                `echo #{info_plist_content} > #{plist_path}`
            end
            file = FileEdit.new(plist_path)
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
            
        end
        
        def project_destination 
            "./#{@project_name}/"
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
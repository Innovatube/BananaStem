module Carbidsetup
    class Command
        def add_pod(pod)
        end

        def add_url_scheme(url)
            # if !line_exist_in_file?(@info_plist_path, /\A<key>CFBundleURLTypes<\/key>\z/)
            #   add_line_under_line(@info_plist_path,/<dict>/, "<key>CFBundleURLTypes</key>
            #   ") 
            # end
            
            # add_line_under_line(@info_plist_path, /\A<key>CFBundleURLTypes<\/key>\z/,
            # "<dict>
            # <key>CFBundleTypeRole</key>
            # <string>Editor</string>
            # <key>CFBundleURLSchemes</key>
            # <array>
            # <string>#{url}</string>
            # </array>
            # </dict>
            # ")
        end
    end 
end 
module Carbidsetup
    class Facebooksetup
        def setup_facebook
            url = 'https://developers.facebook.com/docs/facebook-login/ios'
            `open #{url}`
            puts "Please add the current project bundle id to the facebook developer settings"
            appID = ask("Please return your appID") { |q| q.validate = /\Afb\d+\z/ }
            display_name = ask("Please return your display name ?")
            url_scheme = ask("Please return your url scheme ?")
            if appID 
                add_facebook_permissions
                
                add_line_under_line(@info_plist_path, /<dict>/,
                "<key>FacebookAppID</key>
                <string>#{appID}</string>
                <key>FacebookDisplayName</key>
                <string>#{display_name}</string>
                ")
                
                add_url_scheme url_scheme
                
                puts "Adding the delegate setup service file to the project"
            end 
            pods << "FBSDKCoreKit"
            pods << "FBSDKLoginKit"
        end  
        
        def add_facebook_permissions  
            add_line_under_line(@info_plist_path, /<dict>/, "<key>LSApplicationQueriesSchemes</key>
            <array>
            <string>fbapi</string>
            <string>fb-messenger-api</string>
            <string>fbauth2</string>
            <string>fbshareextension</string>
            </array>
            ")
        end 
    end 
end
module Carbidsetup
    class Googlesetup
        def setup_google
            url = 'https://developers.google.com/mobile/add?platform=ios&cntapi=signin&cntapp=Default%20Demo%20App&cntpkg=com.google.samples.quickstart.SignInExample'
            `open #{url}`
            puts "Please setup the project name and download the config file"
            reversed_id = ask("What is the REVERSED_ID ? It can be found in the google-info.plist file you just downloaded")
            add_url_scheme(reversed_id)
            puts "Copy the delegate service file into the project"
            
            pods << "Google/SignIn"      
        end 
    end 
end
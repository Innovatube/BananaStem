require "carbidsetup/version"
require 'highline'
require 'cocoapods'
module Carbidsetup
  class Main < HighLine
    attr_accessor :pods
    attr_accessor :info_plist_path
    def run 
<<<<<<< HEAD
      project_path = Dir.glob('./*.xcodeproj').first
      if project_file
        say("Setting up files for project #{project_name}")
=======
      @pods = []
      project_path = Dir.glob('*.xcodeproj').first
      if project_path
        say("Setting up files for project #{project_path}")
>>>>>>> develop
      else
        say("Couldn't find *.xcproject file. Please cd into the correct folder of the project file")
        abort
      end 
      podfile_path = Dir.glob('./podfile').first
      unless podfile_path
        say("Couldn't find podfile. Please pod init first before running this")
      end 
      
      project_name = project_path.split('.').first
      
<<<<<<< HEAD
      info_plist_path = File.open('./#{project_name}/info.plist')
      info_plist = Nokogiri.xml(info_plist)
      podfile = File.open(podfile_path)
=======
      @info_plist_path = "./#{project_name}/info.plist"
>>>>>>> develop
      
      puts '#{podfile}'
      puts '#{info_plist}'

      choose do |menu|
        menu.prompt = "Add drawer menu ?"
        menu.choice(:yes) { @pods << "SlideMenuControllerSwift" }
        menu.choice(:no) { puts(" Do nothing and continue")}
        menu.default = :no
      end 
      
      choose do |menu|
        menu.prompt = "Authentication with google ?"
        menu.choice(:yes) { setup_google }
        menu.choice(:no) { say "To the next question" }
        menu.default = :yes
      end 
      
      choose do |menu|
        menu.prompt = "Authentication with facebook ?"
        menu.choice(:yes) { setup_facebook }
        menu.choice(:no) { say "To the next question"}
      end 
      
      add_line_under_line("podfile",/use_frameworks!/, pods_to_string)
      # `pod install` Trying to run pod install 
    end 
    
    def setup_google
      url = 'https://developers.google.com/mobile/add?platform=ios&cntapi=signin&cntapp=Default%20Demo%20App&cntpkg=com.google.samples.quickstart.SignInExample'
      `open #{url}`
      puts "Please setup the project name and download the config file"
      reversed_id = ask("What is the REVERSED_ID ? It can be found in the google-info.plist file you just downloaded")
      add_url_scheme(reversed_id)
      puts "Copy the delegate service file into the project"
      
      pods << "Google/SignIn"      
    end 
    
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
    
    def add_url_scheme(url)
      # if !line_exist_in_file?(@info_plist_path, /\A<key>CFBundleURLTypes<\/key>\z/)
      #   add_line_under_line(@info_plist_path,/<dict>/, "<key>CFBundleURLTypes</key>
      #   ") 
      # end
      
      add_line_under_line(@info_plist_path, /\A<key>CFBundleURLTypes<\/key>\z/,
      "<dict>
      <key>CFBundleTypeRole</key>
      <string>Editor</string>
      <key>CFBundleURLSchemes</key>
      <array>
      <string>#{url}</string>
      </array>
      </dict>
      ")
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
    
    def new_xml_node(name, content = "")
      node = Nokogiri::XML::Node.new name @info_plist
      node.content = content
    end 
    
    def pods_to_string
      @pods.map { |pod| "pod #{pod} " }.join("")
    end
    
    def add_line_under_line(file, catch_line, line_to_add)
      f = File.open(file, "r+")
      output = ""
      f.each do |line| 
        if catch_line.match(line.strip)
          output << line
          output << line_to_add
        else
          output << line  
        end
      end
      f.close
      f =  File.open(file, "w") { |f| f << output }
      f.close
    end
    
    def line_exist_in_file?(file, line)
      File.readlines(file).grep(line).size > 0    
    end 
    
  end 
end
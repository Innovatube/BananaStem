require "carbidsetup/version"
require 'highline'
require 'nokogiri'
module Carbidsetup
  class Main < HighLine
    @pods = Array.new
    def run 
      project_path = Dir.glob('*.xcodeproj').first
      if project_path
        say("Setting up files for project #{project_path}")
      else
        say("Couldn't find *.xcproject file. Please cd into the correct folder of the project file")
        abort
      end 
      podfile_path = Dir.glob('./podfile').first
      unless podfile_path
        say("Couldn't find podfile. Please pod init first before running this")
      end 
      
      project_name = project_path.split('.').first
      
      info_plist_path = File.open("./#{project_name}/info.plist")
      @info_plist = Nokogiri.XML(info_plist_path)
      podfile = File.open(podfile_path)
      
      puts "#{podfile}"
      puts "#{@info_plist}"
      
      choose do |menu|
        menu.prompt = "Add drawer menu ?"
        menu.choice(:yes) { pods.append "SlideMenuControllerSwift" }
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
      
      add_to_podfile pods_to_string
      `pod install`
    end 
    
    def setup_google
      url = 'https://developers.google.com/mobile/add?platform=ios&cntapi=signin&cntapp=Default%20Demo%20App&cntpkg=com.google.samples.quickstart.SignInExample'
      `open #{url}`
      "Please setup the project name and download the config file")
      reversed_id = ask("What is the REVERSED_ID ? It can be found in the google-info.plist file you just downloaded") { |id| id.strip! }
      if reversed_id
        add_url_scheme reversed_id
        
        puts "Copy the delegate service file into the project"
      end 
      pods.append "Google/SignIn"      
    end 
    
    def setup_facebook
      url = 'https://developers.facebook.com/docs/facebook-login/ios'
      `open #{url}`
      bundle_id = say("Please add the current project bundle id to the facebook developer settings")
      appID = ask("Please return your appID") { |q| q.validate = /\Afb\d+\z/ }
      display_name = ask("Please return your display name ?")
      url_scheme = ask("Please return your url scheme ?")
      if appID 
        add_facebook_permissions

        dict_root_node.add_child 
        "<key>FacebookAppID</key>
        <string>#{appID}</string>
        <key>FacebookDisplayName</key>
        <string>#{display_name}</string>"

        add_url_scheme url_scheme

        puts "Adding the delegate setup service file to the project"
      end 
      pods.append "FBSDKCoreKit"
      pods.append "FBSDKLoginKit"
    end 
    
    def url_scheme_node
      @info_plist.at('key:contains("CFBundleURLTypes")').next_element
    end 
    
    def dict_root_node 
    end 
    
    def add_url_scheme(url)
      url_scheme_node.add_child 
      "<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
      <string>#{url}</string>
			</array>
      </dict>"
    end
    
    def add_facebook_permissions    
      @info_plist.at('key:contains("CFBundleURLTypes")').add_next_sibling "<key>LSApplicationQueriesSchemes</key>
      <array>
      <string>fbapi</string>
      <string>fb-messenger-api</string>
      <string>fbauth2</string>
      <string>fbshareextension</string>
      </array>"
    end 
    
    def new_xml_node(name, content = "")
      node = Nokogiri::XML::Node.new name @info_plist
      node.content = content
    end 
    
    def pods_to_string
      @pods.map { |pod| "/n pod #{pod} " }.join("")
    end 
    
    def add_to_podfile(line_to_add)
      use_framework_line = 0 
      File.open("podfile").each do |line|
        puts line_to_add if /use_frameworks!/.match(line)
      end      
    end 
  end 
end
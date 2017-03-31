require "carbidsetup/command"
require "carbidsetup/constants"
require "fileutils"
module Carbidsetup
    class Loginscreen < Command        
        LOGIN_FB_GG_TEMPLATE = "carbidsetup/template_files/login_with_fb_gg/"
        LOGIN_WITHOUT_TEMPLATE = 
        "carbidsetup/template_files/login_without"
        LOGIN_FACEBOOK_TEMPLATE = 
        "carbidsetup/template_files/login_with_google"
        LOGIN_GOOGLE_TEMPLATE = 
        "carbidsetup/template_files/login_with_facebook"
        
        def run 
            case @options["authentication"]
                when "facebook"
                    FileUtils.move LOGIN_FACEBOOK_TEMPLATE project_destination
                    add_facebook_pods
                when "google" 
                    FileUtils.move LOGIN_GOOGLE_TEMPLATE project_destination
                    add_google_pod
                when "facebook_google"
                    FileUtils.move LOGIN_FB_GG_TEMPLATE project_destination
                    add_facebook_pods
                    add_google_pod
                else 
                    FileUtils.move LOGIN_WITHOUT_TEMPLATE project_destination
            end
        end

        def add_facebook_pods
            Constants::Pods::FACEBOOK.each { |pod| add_pod(pod) }
        end 
        
        def add_google_pod
            add_pod(Constants::Pods::GOOGLE)
        end   
    end 
end 
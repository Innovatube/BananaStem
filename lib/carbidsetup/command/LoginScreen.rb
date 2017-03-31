require "carbidsetup/command"
require "carbidsetup/constants"
require "fileutils"
module Carbidsetup
    class Loginscreen < Command        
        FB_GG_TEMPLATE = "lib/carbidsetup/template_files/login_view/login_with_fb_gg/Login"
        WITHOUT_TEMPLATE = "lib/carbidsetup/template_files/login_view/login_without/Login"
        FACEBOOK_TEMPLATE = "lib/carbidsetup/template_files/login_view/login_with_google/Login"
        GOOGLE_TEMPLATE = "lib/carbidsetup/template_files/login_view/login_with_facebook/Login"
        
        def run
            case @options["authentication"]
                when "facebook"
                    FileUtils.copy_entry(FACEBOOK_TEMPLATE ,project_destination)
                    add_facebook_pods
                when "google" 
                    FileUtils.copy_entry(GOOGLE_TEMPLATE,project_destination)
                    add_google_pod
                when "facebook_google"
                    FileUtils.copy_entry(FB_GG_TEMPLATE,project_destination)
                    add_facebook_pods
                    add_google_pod
                else 
                    FileUtils.copy_entry(WITHOUT_TEMPLATE,project_destination)
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
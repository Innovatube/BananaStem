require "carbidsetup/command"
require "carbidsetup/constants"
require "fileutils"
module Carbidsetup
    class Loginscreen < Command        
        FB_GG_TEMPLATE = "../template_files/login_view/login_with_fb_gg/Login"
        WITHOUT_TEMPLATE = "../template_files/login_view/login_without/Login"
        FACEBOOK_TEMPLATE = "../template_files/login_view/login_with_google/Login"
        GOOGLE_TEMPLATE = "../template_files/login_view/login_with_facebook/Login"
        
        def run
            case @options["authentication"]
                when "facebook"
                    FileUtils.copy_entry(facebook_template ,project_destination)
                    add_facebook_pods
                when "google" 
                    FileUtils.copy_entry(google_template,project_destination)
                    add_google_pod
                when "facebook_google"
                    FileUtils.copy_entry(facebook_google_template,project_destination)
                    add_facebook_pods
                    add_google_pod
                else 
                    FileUtils.copy_entry(without_template,project_destination)
            end
        end

        def add_facebook_pods
            Constants::Pods::FACEBOOK.each { |pod| add_pod(pod) }
        end 

        def facebook_template 
            File.join(File.dirname(File.expand_path(__FILE__)),FACEBOOK_TEMPLATE)
        end 
        def google_template 
            File.join(File.dirname(File.expand_path(__FILE__)), GOOGLE_TEMPLATE)
        end 
        
        def facebook_google_template 
            File.join(File.dirname(File.expand_path(__FILE__)), FB_GG_TEMPLATE)
        end 
        
        def without_template 
            File.join(File.dirname(File.expand_path(__FILE__)), WITHOUT_TEMPLATE)
        end 
        
        def add_google_pod
            add_pod(Constants::Pods::GOOGLE)
        end   
    end 
end 
require "carbidsetup/command"
require "fileutils"
module Carbidsetup
    class Listscreen < Command
        TEMPLATE = "../template_files/list_view/List"
        def run 
            FileUtils.copy_entry(list_view_template, project_destination)
        end

        def list_view_template
            File.join(File.dirname(File.expand_path(__FILE__)),TEMPLATE)
        end            
    end
end
require "carbidsetup/command"
require "fileutils"
module Carbidsetup
    class Listscreen < Command
        TEMPLATE = "lib/carbidsetup/template_files/list_view/List"
        def run 
            FileUtils.copy(TEMPLATE, project_destionation)
        end
    end
end
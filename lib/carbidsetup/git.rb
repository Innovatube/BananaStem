require "carbidsetup/command"

module Carbidsetup
    class Git < Command
        RAW_IOSPROJECT_REPO = "https://github.com/jimmypham92/templates-ios.git"

        def self.archive_raw_ios_project(project_destination)
            `git clone #{RAW_IOSPROJECT_REPO} #{project_destination} && rm -rf #{@project_name}/.git`
        end

    end
end
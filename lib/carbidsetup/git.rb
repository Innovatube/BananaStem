require "carbidsetup/command"

module Carbidsetup
    class Git < Command
        IOS_TEMPLATE_REPO = "https://github.com/Innovatube/iOS-Templates.git"
        RAW_PROJECT_BRANCH = "raw_ios_project"

        def self.archive_raw_ios_project(project_destination)
            `git clone #{IOS_TEMPLATE_REPO} --branch #{RAW_PROJECT_BRANCH} --single-branch #{project_destination}`
        end

        private_constant :IOS_TEMPLATE_REPO, :RAW_PROJECT_BRANCH
    end
end

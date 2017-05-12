require "carbidsetup/command"

module Carbidsetup
    class Git
        def self.git_url_isValid?(url)
            !(/https:\/\/github.com\/\w+\/\w+.git/ =~ url).nil?
        end 

        def self.download_git_master(url)
            git_shallow_clone(url, "master")
            remove_git
        end

        def self.git_shallow_clone(url, branch)
            if git_url_isValid?(url)
                `git clone --depth 1 --branch #{branch} #{url}`
            else 
                raise CarbidsetupError, 'Invalid git repo url'
            end
        end

        def self.remove_git
            `rm -rf *.git`
        end 
    end
end

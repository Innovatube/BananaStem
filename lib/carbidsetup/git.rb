module Carbidsetup
    module Git
        class << self 
            def git_url_isValid?(url)
                !(/https:\/\/github.com\/\w+\/[\w-]+.git/ =~ url).nil?
            end 
            
            def repo_name(git_url)
                /[\w-]+.git/.match(git_url).to_s.chomp '.git'
            end 
            
            def download_git_master(url)
                git_shallow_clone(url, "master")
                remove_git
            end
            
            def git_shallow_clone(url, branch)
                if git_url_isValid?(url)
                    `git clone --depth 1 --branch #{branch} #{url} #{self.repo_name(url)}`
                elsif 
                    raise CarbidsetupError, 'Invalid git repo url'
                end
            end
            
            def remove_git
                `rm -rf *.git`
            end 
        end
    end
end 

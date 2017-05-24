require 'carbidsetup'
describe Carbidsetup::Git do 
    context '::git_url_isValid?' do 
        it 'should work' do 
            expect(Carbidsetup::Git.git_url_isValid? "https://github.com/doraeminemon/Xcodeproj.git").to be true
            expect(Carbidsetup::Git.git_url_isValid? "https://www.github.com/doraeminemonsomerepo").to be false 
            expect(Carbidsetup::Git.git_url_isValid? "asdasd").to be false 
        end 
        it 'should work with url contains dash' do 
            expect(Carbidsetup::Git.git_url_isValid? 'https://github.com/Innovatube/ios-clean-boilerplate.git').to be true 
        end 
    end 
    
    context '::repo_name' do 
        it 'should work' do 
            expect(Carbidsetup::Git.repo_name 'https://github.com/SimplicityMobile/Simplicity.git').to eql 'Simplicity'
        end 
    end 
    
    context '::remove_git' do 
        it 'should work' do 
        end 
    end 
    context '::git_shallow_clone' do 
        it 'should work' do 
        end 
    end 
end 
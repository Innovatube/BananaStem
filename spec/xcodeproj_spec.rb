require 'xcodeproj'
describe Xcodeproj::Project do 
    context '::main_project' do 
        it 'should work' do 
            main_project = Xcodeproj::Project.main_project('./TestProject')
            expect(main_project).to be_an_instance_of Xcodeproj::Project
        end 
        
        it 'should raise error when the project file isn\'t exist' do 
            expect{Xcodeproj::Project.main_project('./TestProject')}.to raise_error Carbidsetup::CarbidsetupError
        end
    end 

    context '::add_file' do 
        it 'should work' do 
            # Xcodeproj::Project.add_file('./TestProject/AppDelegate.swift')
        end 
    end 
end 

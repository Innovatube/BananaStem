require 'rspec'
require 'yaml'
describe Carbidsetup::Main do 
    context '#stem_from_template' do 
        it 'should open file correctly' do 
            stem_file = Carbidsetup::Main.new().stem_from_template fixture_path('stem2.yaml')
            #TODO
        end 
        it 'should load stem.yaml if no file is provided' do 

        end 
    end 
end 

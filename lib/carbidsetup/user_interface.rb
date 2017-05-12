module Carbidsetup 
    require "colored2"
    module UserInterface 
        @title_colors      =  %w( yellow green )
        @title_level       =  0
        @indentation_level =  2
        @warnings = []
        
        class << self 
            def message(message)
            end 
            
            def warn(message)
                @warnings << message
            end 
            
            def notice(message)
                puts("\n[!] #{message}".green)
            end 
            
            def prints_warnings 
                $stdout.flush
                @warnings.each do |warning|
                    $stderr.puts("\n[!] #{warning}".yellow)
                end
            end 
            
        end 
    end 
end 


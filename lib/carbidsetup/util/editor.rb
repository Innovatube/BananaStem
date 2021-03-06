# Copy from chef's source code

module Carbidsetup
    class Editor
        attr_reader :lines
        
        def initialize(lines)
            @lines = lines.to_a.clone
        end
        
        def append_line_after(search, line_to_append)
            lines = []
            
            @lines.each do |line|
                lines << line
                lines << line_to_append if line.match(search)
            end
            
            (lines.length - @lines.length).tap { @lines = lines }
        end
        
        def append_line_if_missing(search, line_to_append)
            count = 0
            
            unless @lines.find { |line| line.match(search) }
            count = 1
            @lines << line_to_append
        end
        
        count
    end

    def line_existed?(search)
        @lines.find { |line| line.match(search) }
    end 
    
    
    def remove_lines(search)
        count = 0
        
        @lines.delete_if do |line|
            count += 1 if line.match(search)
        end
        
        count
    end
    
    def replace(search, replace)
        count = 0
        
        @lines.map! do |line|
            if line.match(search)
                count += 1
                line.gsub!(search, replace)
            else
                line
            end
        end
        
        count
    end
    
    def replace_lines(search, replace)
        count = 0
        
        @lines.map! do |line|
            if line.match(search)
                count += 1
                replace
            else
                line
            end
        end
        
        count
    end
end
end
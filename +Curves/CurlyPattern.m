classdef CurlyPattern < Curves.Pattern   
    
    methods
        function self = CurlyPattern(twists)    
            t=linspace(0,1,1000)';
            path=[t,cos(twists*2*pi*t),sin(twists*2*pi*t)];
            self = self@Curves.Pattern(path);
        end        
    end
end


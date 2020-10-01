classdef CurlyPath < Curves.Path   
    
    methods
        function self = CurlyPath(twists)    
            t=linspace(0,1,1000)';
            path=[t,cos(twists*2*pi*t),sin(twists*2*pi*t)];
            self = self@Curves.Path(path);
        end        
    end
end


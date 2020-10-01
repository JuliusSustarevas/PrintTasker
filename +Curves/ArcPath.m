classdef ArcPath < Curves.Path

    methods

        function self = ArcPath(angle)
            t = linspace(0, 1, 100)';
            path = [cos(angle * t) sin(angle * t) zeros(100, 1)];         
            self = self@Curves.Path(path);
        end

    end

end

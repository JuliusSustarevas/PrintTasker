classdef (Abstract) Pattern < Curves.Path

    methods

        function self = Pattern(path)
            self = self@Curves.Path(path);
        end

        function valid = is_valid(self)
            % is_valid  Check if pattern is valid
            valid = all(abs(self.path(1, 2:3) - self.path(end, 2:3)) < 1e-5);
        end

        function t = get_t(self)
            t = self.path(:, 1);
        end

    end

end

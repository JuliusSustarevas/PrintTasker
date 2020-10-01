classdef (Abstract) Path < handle

    properties
        path% is a 4x4xn transoforms
    end

    methods

        function self = Path(path)
            self.path = self.normalise_path(path);
        end

        function scale(self, scale_vec)
            % scale  Scale the path along xyz axes
            self.path = self.normalise_path(self.path);
            self.path(:, 1) = self.path(:, 1) * scale_vec(1);
            self.path(:, 2) = self.path(:, 2) * scale_vec(2);
            self.path(:, 3) = self.path(:, 3) * scale_vec(3);
        end

        function h = plot(self)
            % scale  Scale the path along xyz axes
            import Helpers.*
            h = path_plot(self.path);
        end

        function set_density(self, d)
            import Helpers.*
            self.path = sample_densely(self.path, d);
        end

        function traj = to_traj(self, speed, speed_density)
            traj = Curves.Trajectory(self, speed, speed_density);
        end

    end

    methods (Static)

        function path = normalise_path(path)
            % normalise  given path so that its amplitude in any direction is max 1.
            normalise = @(x) x ./ max(abs(x));
            path = [normalise(path(:, 1)), normalise(path(:, 2)), normalise(path(:, 3))];
            path(isnan(path)) = 0;
        end

    end

end

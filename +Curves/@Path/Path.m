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

        function resample(self, d)
            d = diff(self.path);
            cumlength = [0; cumsum(sqrt(sum(d.^2, 2)))];
            [~, IA, ~] = uniquetol(cumlength);
            cumlength = cumlength(IA);
            self.path = self.path(IA, :);
            self.path = interp1(cumlength, self.path, linspace(0, cumlength(end), round(cumlength(end) / density)), 'pchip');
        end

        function superimpose(self, pattern, density)
            %will round  trajectory to multiples of  path lengths
            p_l = max(pattern.path(:, 1));
            corr = pattern.path(:, 1) ./ p_l;
            pcl = pattern.get_cuml();

            cl = self.get_cuml();

            tl = (cl(end) / p_l) * pcl(end);

            s = 0:density:tl;

            patternh = path.get_func();
            pathh = self.get_func();

            tform = self.path2TForm(self)

        end

        function h = get_func(self)
            l = self.get_l();
            h = @(t) interp1(l, self.path, t, 'pchip');
        end

        function t = derive_t(self, speed)
            l = self.get_l();
            t = l ./ speed;
        end

        function cl = get_l(self)
            d = diff(self.path);
            cl = [0; cumsum(sqrt(sum(d.^2, 2)))];
        end

        function valid = is_repeating(self)
            valid = all(abs(self.path(1, 2:3) - self.path(end, 2:3)) < 1e-5);
        end

        function h = plot(self)
            % scale  Scale the path along xyz axes
            x = self.path(:, 1); path2TForm
            ay = squeeze(tform(1:3, 2, n))';
            az = squeeze(tform(1:3, 3, n))';
            hold on
            quiver3(x, y, z, ax(:, 1), ax(:, 2), ax(:, 3), 'r');
            quiver3(x, y, z, ay(:, 1), ay(:, 2), ay(:, 3), 'g');
            quiver3(x, y, z, az(:, 1), az(:, 2), az(:, 3), 'b');
            hold off
        end

    end

    methods (Static)

        function path = normalise_path(path)
            % normalise  given path so that its amplitude in any direction is max 1.
            normalise = @(x) x ./ max(abs(x));
            path = [normalise(path(:, 1)), normalise(path(:, 2)), normalise(path(:, 3))];
            path(isnan(path)) = 0;
        end

        function tform = path2TForm(path)
            n = length(path.path);
            ax = diff(path.path, 1);
            ax = [ax; ax(end, :)];

            %For trajectories made from 2d paths, assume Z only rotation
            ex = zeros(n, 1);
            ey = zeros(n, 1);
            ez = atan2(ax(:, 2), ax(:, 1));
            rotm = eul2rotm([ez, ey, ex], "ZYX");
            tform = rotm2tform(rotm);
            tform(1, 4, :) = path.path(:, 1);
            tform(2, 4, :) = path.path(:, 2);
            tform(3, 4, :) = path.path(:, 3);
        end

    end

end

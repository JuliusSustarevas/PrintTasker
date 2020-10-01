    function h = curve_plot(curve)
            % scale  Scale the pattern along xyz axes
            x = curve(:, 1);
            y = curve(:, 2);
            z = curve(:, 3);
            c = colormap("winter");
            t = (1:length(x)) ./ length(x);
            c = interp1(linspace(0, 1, length(c)), c, t);
            h = scatter3(x, y, z, 5, c, 'filled')
        end
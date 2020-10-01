    function h = trajectory_plot(trajectory, t, frame_density)
        x = squeeze(trajectory(1, 4, :));
        y = squeeze(trajectory(2, 4, :));
        z = squeeze(trajectory(3, 4, :));

        ax = squeeze(trajectory(1:3, 1, :));
        ay = squeeze(trajectory(1:3, 2, :));
        az = squeeze(trajectory(1:3, 3, :));

        n = find([0 diff(round(t ./ frame_density))]); % find entries that go over density threshold

        c = colormap("winter");
        l = (1:length(x)) ./ length(x);
        c = interp1(linspace(0, 1, length(c)), c, l);

        h = scatter3(x, y, z, 5, c, 'filled');
        hold on
        quiver3(x(n), y(n), z(n), ax(1,n)', ax(2,n)', ax(3,n)', 'r');
        quiver3(x(n), y(n), z(n), ay(1,n)', ay(2,n)', ay(3,n)', 'g');
        quiver3(x(n), y(n), z(n), az(1,n)', az(2,n)', az(3,n)', 'b');
        hold off
    end

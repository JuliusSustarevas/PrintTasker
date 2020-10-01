function curve = sample_densely(curve, density)
    d = diff(curve);
    cumlength = [0; cumsum(sqrt(sum(d.^2, 2)))];
    [~,IA,~] = uniquetol(cumlength);
    cumlength=cumlength(IA);
    curve=curve(IA,:);
    curve = interp1(cumlength, curve, linspace(0, cumlength(end), round(cumlength(end) / density)), 'pchip');
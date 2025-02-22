function [track1, track2, track3] = ATL03_read(FILE_NAME)


file_id = H5F.open (FILE_NAME, 'H5F_ACC_RDONLY', 'H5P_DEFAULT');

info = h5info (FILE_NAME);

track = 'gt1l';
ATL03_sub1;
track1=[lon lat temp];
track = 'gt2l';
ATL03_sub1;
track2=[lon lat temp];
track = 'gt3l';
ATL03_sub1;
track3=[lon lat temp];
H5F.close (file_id);

% Create the graphics figure.
f = figure('Name', [FILE_NAME], ...
           'Renderer', 'zbuffer', ...
           'Position', [0,0,800,600], ...
           'visible','off');

% Put title.
var_name = sprintf('%s', long_name_temp);
tstring = {FILE_NAME;track;var_name};
title(tstring,...
      'Interpreter', 'none', 'FontSize', 16, ...
      'FontWeight','bold');
axesm('MapProjection','eqdcylin','Frame','on','Grid','on', ...
      'MeridianLabel','on','ParallelLabel','on','MLabelParallel','south')

ind = floor(linspace(1,size(lon,1),10000));

scatterm(lat, lon, 1, temp);
h = colorbar();
units_str = sprintf('%s', char(units_temp));
set (get(h, 'title'), 'string', units_str, 'FontSize', 8, ...
                   'Interpreter', 'None', ...
                   'FontWeight','bold');

% Plot world map coast line.
coast = load('coast.mat');
plotm(coast.lat, coast.long, 'k');
tightmap;
saveas(f, [FILE_NAME '_' track '.m.png']);


end

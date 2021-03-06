function antenna_gain_plot3 (data_rhcp, data_lhcp, dir, maxval, I, open_figure)
if (nargin < 3),  dir = [];  end
if (nargin < 4),  maxval = [];  end
if (nargin < 5) || isempty(I),  I = [2];  end
if (nargin < 6) || isempty(open_figure),  open_figure = true;  end

if ~strcmpi(data_rhcp.type, 'gain'),  return;  end

data = {data_rhcp, data_lhcp};
%for i=1:2  % for each offset-gain, non-offset-gain.
%for i=1
for i=rowvec(I)
if open_figure,  figure();  end
for j=1:2  % for each RHCP, LHCP
    switch i
    case 1
        tempa = (data{j}.profile.final.^2);
        tempaa = (data{j}.sphharm.final_fit.^2);
        tit = sprintf('Power gain (linear)\n%s', data{j}.filename(1:end-9));
        filename = [data{j}.filename(1:end-9) '-power.png'];
        temp1 = max(max(data{1}.sphharm.final.^2), ...
                    max(data{1}.sphharm.final_fit.^2));
        temp2 = min(min(data{1}.sphharm.final.^2), ...
                    min(data{1}.sphharm.final_fit.^2));
    case 2
        tempa = (data{j}.profile.final);
        tempaa = (data{j}.sphharm.final_fit);
        tit = sprintf('Amplitude gain (linear)\n%s', data{j}.filename(1:end-9));
        filename = [data{j}.filename(1:end-9) '-amplitude.png'];
        temp1 = max(max(data{1}.sphharm.final), ...
                    max(data{1}.sphharm.final_fit));
        temp2 = min(min(data{1}.sphharm.final), ...
                    min(data{1}.sphharm.final_fit));
    end
    %temp1, temp2  % DEBUG
    switch j
    case 1  % RHCP
        color = 'b';
    case 2  % LHCP
        color = 'r';
    end
temp5 = 0.5;  
temp6 = 0.25;
temp1 = ceil(temp1/temp6)*temp6;
if ~isempty(maxval),  temp1 = maxval;  end
%temp4 = [];
ang2 = data{j}.profile.ang*pi/180;
idx = (data{j}.profile.azim == 180);
ang2(idx) = -ang2(idx);
%figure, plot(ang2, temp, '-k')
pp(ang2, tempa, ...  % raw values
    'RingStep',temp5, ...
    ...%'RingTickLabel',temp4, ...
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    ...%'CentreValue',temp2, ...
    ...%'Marker','.', ...
    'AngleFontSize', get(0, 'DefaultAxesFontSize'), ...
    'RingFontSize',  get(0, 'DefaultAxesFontSize'), ...
    'RingLineWidth',  2, ...
    'AngleLineWidth', 2, ...
    'Marker','none', ...
    'LineStyle','-', ...
    'LineColor','k', ...
    'LineWidth',2 ...
)
%pause
hold on
pp(ang2, tempaa, ...  % fitted values
    'ThetaDirection','cw', ...
    'ThetaStartAngle',+270, ...
    'MaxValue',temp1, ...
    ...%'CentreValue',temp2, ...
    'AngleFontSize', get(0, 'DefaultAxesFontSize'), ...
    'RingFontSize',  get(0, 'DefaultAxesFontSize'), ...
    'RingLineWidth',  2, ...
    'AngleLineWidth', 2, ...
    'Marker','none', ...
    'LineStyle','-', ...
    'LineColor',color, ...
    'LineWidth',2 ...
)
hold on
axis equal
title(tit, 'Interpreter','none')
end
if ~isempty(dir)  
  saveas(gcf, fullfile(dir, filename))
  close(gcf)
end
end

end

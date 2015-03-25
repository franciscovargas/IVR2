function thresh = threshold(value)
%{
The following parameters were
extracted by inspecting the
gray scale hist (this is silly)
and playing around with values
None norm good params:
    red: 128, 164
    green: 150, 164
    blue: 150, 164
Following settings were extracted
by examining the histogram of each 
collor channel and choosing values
accordingly
Normed good params:
    red: 0.513, 0.572
    green: 0.549, 0.612
    blue: 0.525. 0.529
smothed histograms are kinda shit
updated upper bounds:
    r: 0.6026
    g: 0.6096
    b: 0.616
    
%}

% img = imread('train14.jpg');
% dimensions of the image
[height width] = size(value);


sizeparam = 8;
low_green = 60.0 / 360.0;
high_green = 150 / 360.0;

output = zeros(height, width);
for row = 1 : height
    for col = 1 : width
        if value(row,col) < high_green ... % inside high bnd
        & value(row,col) >  low_green % optional low bnd
            output(row,col) = 1;
        else
            output(row,col) = 0;
        end
    end
end
[label na] = bwlabel(output);
property = regionprops(label, 'all');
disp('AREA');
areas = [property.Area];
if size(areas) > 0
    if areas(1) > 150
        areas(1)
        disp('SHIT');
        imshow(output);
        DIE_KEVIN
    end;
end;
disp('AREA');
thresh = output;
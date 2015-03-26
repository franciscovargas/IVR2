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
updated upper bounds:
    r: 0.6026
    g: 0.6096
    b: 0.616
    
%}

% initialise boolean variable thresh
thresh = 0;

% extract the height and width of the image
[height width] = size(value);

% define the parameters
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

% remove noise
output = bwareaopen(output, 5);
[label na] = bwlabel(output);
property = regionprops(label, 'all');
areas = [property.Area];

imshow(output);
%if intruder is identified
if size(areas) > 0
    if areas(1) > 80
        thresh = 1;
    end;
end;

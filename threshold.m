function thresh = threshold(value)

% initialise boolean variable thresh
thresh = 0;

% extract the height and width of the image
[height width] = size(value);

% define the parameters
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
%if intruder is identified (depending on the size of the object compared to the frame)
% we select anything larger than 1/50 of the picture area
img_area = height * width;

if size(areas) > 0
    if areas(1) > img_area/50
        thresh = 1;
    end;
end;

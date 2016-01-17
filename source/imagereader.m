clc;clear all;
classColor = [255 0 0; 0 255 0; 0 0 255; 255 255 0; 0 255 255; 255 0 255; 222 184 135; 75 0 130; 124 252 0];

% read the input image 
[X,map] = imread('input.png');
[m,n,p] = size(X);

% pixelPPI will store no. of times 
% pixel is selected as end member
ppiScore = zeros(m,n);

for iteration = 1:10
    % create the skewer for projection using random number generator
    skewer = randperm(15,3);
    projections = zeros(m,n);
    for i = 1:m
        for j = 1:n
            rgb = [X(i,j,1);X(i,j,2);X(i,j,3)];
            projections(i,j) = dot(single(skewer),single(rgb));
        end
    end
    %[extremel,locl] = min(projections(:));
    %extremel
    %[rl cl] = ind2sub(size(projections),locl)
    %ppiScore(rl, cl) = ppiScore(rl, cl) + 1;
    
    [extremeu,locu] = max(projections(:));
    [ru cu] = ind2sub(size(projections),locu);
    ppiScore(ru, cu) = ppiScore(ru, cu) + 1;
end

% Specify the number of end members
noOfClasses = 3;
% endMembers stores the position of end member pixels
endMembersCoords = zeros(noOfClasses,2);

for class = 1:noOfClasses
    [x,y] = max(ppiScore(:));
    [r c] = ind2sub(size(ppiScore),y);
    endMembersCoords(class,1)= r;
    endMembersCoords(class,2)= c;
    ppiScore(r, c) = -1;
end

output = zeros(m,n,3);
% Implement the SAM to classify all the pixels in the image
for i = 1:m
    for j = 1:n
        % check the spectral angle with each of the end member
        spectralAngle = zeros(1,noOfClasses);
        for c = 1 : noOfClasses
            xc = endMembersCoords(c,1);
            yc = endMembersCoords(c,2);
            pixel = [X(i,j,1);X(i,j,2);X(i,j,3)];
            endMember = [X(xc,yc,1);X(xc,yc,2);X(xc,yc,3)]; 
            magPixel = double(sqrt(sum(pixel .* pixel)));
            magEndMember = double(sqrt(sum(endMember .* endMember)));
            spectralAngle(c) = acosd(double(dot(single(pixel),single(endMember)))/single((magPixel*magEndMember)));
        end
        [minSA, classIndex] = min(spectralAngle);

        output(i,j,1) = classColor(classIndex,1);
        output(i,j,2) = classColor(classIndex,2);
        output(i,j,3) = classColor(classIndex,3);
    end
end


imwrite(output,'C:/xampp/htdocs/asip/output.png','png');


image_rgb = imread('fruits.png');
image = im2double(rgb2gray(image_rgb)); 

% COMMENT OUT IMSHOWs TO SEE IMAGES. THEY ARE ALSO INCLUDED IN THE HOMEWORK FOLDER.
%imshow(image,[]);

FT_image = FourierTransform(image);
%imshow(image,[]);

magnitude_matrix = abs(FT_image);      
%%abs returns each magnitute for the complex number matrix.

phase_angle_matrix = angle(FT_image);     
%%angle returns the angle that is between -pi and pi,
%now, the variable has 512x512 angle values.

%imshow(FT_image_mag, []);
%imshow(FT_image_ang, []);

%generate the low pass filter:
dimension = 512;
lowerInterval = dimension * 3 / 8;
upperInterval = dimension - ( dimension * 3 / 8);
LP = zeros(dimension, dimension);

for m = lowerInterval:upperInterval
    for n = lowerInterval:upperInterval
        LP(m,n) = 1;
    end
end
m = 0;
n = 0;

Filtered_Image = InverseFourierTransform(LP.*FT_image);
%imshow(real(Filtered_Image),[])
%this effect blurs the image!

HP = ones(dimension, dimension);    % 1 in every cell.
HP = HP - LP;                       
% subtract LP to achieve 0 in middle cells ranging from (192, 320).

Filtered_Image = InverseFourierTransform(HP.*FT_image);
% imshow(real(Filtered_Image2),[])
% this effect shows the edges of fruits. Other parts of the image are more
% like gone.

%
FT_image = FourierTransform(image);
dimension = 512;
upperInterval = dimension * 11 / 16;
lowerInterval = dimension - ( dimension * 11 / 16);

LP = zeros(dimension, dimension);
for m = lowerInterval:upperInterval
    for n = lowerInterval:upperInterval
        LP(m,n) = 1;
    end
end
m = 0;
n = 0;

Filtered_Image = InverseFourierTransform(LP.*FT_image);
imshow(real(Filtered_Image),[])
HP = ones(dimension, dimension);    % 1 in every cell.
HP = HP - LP;  

Filtered_Image = InverseFourierTransform(HP.*FT_image);
%imshow(real(Filtered_Image),[])
%this effect blurs the image!
% subtract LP to achieve 0 in middle cells ranging from (192, 320).


%%%%%%%%%%%%% PART 2

% implement 2Dconv...

%

%size of the image is 512x512.
[x1,y1,z1] = size(image_rgb);

deltaOne = zeros(dimension, dimension);
for i = 1:x1
    for j = 1:y1
        if( i == j - 1)
            deltaOne(i,j) = -1;
        end
    end
end

deltaTwo = zeros(dimension, dimension);
for i = 1:x1
    for j = 1:y1
        if( i == j + 1)
            deltaOne(i,j) = 1;
        end
    end
end

deltaThree = zeros(dimension, dimension);
for i = 1:x1
    for j = 1:y1
        if( i - 1 == j)
            deltaOne(i,j) = -1;
        end
    end
end

hx = deltaOne + deltaTwo;
hy = deltaThree + deltaFour;
deltaFour = zeros(dimension, dimension);
for i = 1:x1
    for j = 1:y1
        if( i + 1 == j)
            deltaOne(i,j) = 1;
        end
    end
end

Filtered_Image = InverseFourierTransform(hx.*FT_image);
%imshow(real(Filtered_Image),[])
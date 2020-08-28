% Load Cover/Host Image
I=imread('lena.png');
% Resize cover image
I=imresize(I,[512 512]);
% Convert to gray 
I=rgb2gray(I);
I=im2double(I);
%Display Cover image
figure(1); imshow(I);
title('host image');
% Load LOGO to be watermarked
ax=imread('carletonlogo.jpg');
% Convert to gray
ax=rgb2gray(ax);
% Resize Logo
ax=imresize(ax,[512 512]);
ax=im2double(ax);
% Display Logo
figure(2); imshow(ax);
title('Carleton logo');
% 3-Level DWT of original image
[ca1,ch1,cv1,cd1]=dwt2(I,'haar');
[ca2,ch2,cv2,cd2]=dwt2(ca1,'haar');
[ca3,ch3,cv3,cd3]=dwt2(ca2,'haar');
% 3-Level DWT of LOGO
[lca1,lch1,lcv1,lcd1]=dwt2(ax,'haar');
[lca2,lch2,lcv2,lcd2]=dwt2(lca1,'haar');
[lca3,lch3,lcv3,lcd3]=dwt2(lca2,'haar');

%Scaling Factor a
a=0.3;

% Embedding Algorithm
newca3=[ca3+(a).*lca3];

%Construction of Watermark Image
newca2= idwt2(newca3,ch3,cv3,cd3,'haar');
newca1= idwt2(newca2,ch2,cv2,cd2,'haar');
watermarked_image= idwt2(newca1,ch1,cv1,cd1,'haar');
figure(3);
imshow(watermarked_image);title('Watermarked Image');

%-------------------- attacks---------------------------%
figure(4) %noise attack
noiseImageAttacked = imnoise(watermarked_image, 'salt & pepper', 0.01);
imshow(noiseImageAttacked);title('Noisy Image');

figure(5) % crop attack
cropImageAttacked = imcrop(watermarked_image, [75 68 340 380]);
imshow(cropImageAttacked);title('Cropped Image');

figure(6) % mean attack
h = fspecial('average', [5, 5]);
meanImageAttacked = filter2(h, watermarked_image);
imshow(meanImageAttacked);title('Mean Attack');

figure(7) % median attack
medianImageAttacked = medfilt2(watermarked_image);
imshow(medianImageAttacked);title('Median Attack');

figure(8) % rotation attack
rotationImageAttacked = imrotate(watermarked_image, 90, 'crop');
imshow(rotationImageAttacked);title('Rotation attack');

figure(9) % shear attack
tformImage = maketform('affine', [1 0 0; 0.5 1 0; 0 0 1]);
shearImageAttacked = imtransform(watermarked_image, tformImage);
imshow(shearImageAttacked);title('Shear Attack');

%-------------------------%-----------
% Watermark extraction

% 3-Level DWT of watermarked image
[nlca1,nlch1,nlcv1,nlcd1]=dwt2(watermarked_image,'haar');
[nlca2,nlch2,nlcv2,nlcd2]=dwt2(nlca1,'haar');
[nlca3,nlch3,nlcv3,nlcd3]=dwt2(nlca2,'haar');

wca3= [(newca3-ca3)./a];

wca2= idwt2(wca3,[],[],[],'haar');
wca1= idwt2(wca2,[],[],[],'haar');
extracted_logo= idwt2(wca1,[],[],[],'haar');

figure(10)
imshow(extracted_logo);title('Extracted Carleton Logo');


%---------------- Peak_Signal_to_Noise_Ration Calulations---------------

%Converting all images to 8-bit unsigned integer array
I=im2uint8(I);
watermarked_image=im2uint8(watermarked_image);
noiseImageAttacked=im2uint8(noiseImageAttacked);
cropImageAttacked=im2uint8(cropImageAttacked);
meanImageAttacked=im2uint8(meanImageAttacked);
medianImageAttacked=im2uint8(medianImageAttacked);
rotationImageAttacked=im2uint8(rotationImageAttacked);
shearImageAttacked=im2uint8(shearImageAttacked);

%Dividing all images by 255
I=I/255;
watermarked_image=watermarked_image/255;
noiseImageAttacked=noiseImageAttacked/255;
cropImageAttacked=cropImageAttacked/255;
meanImageAttacked=meanImageAttacked/255;
medianImageAttacked=medianImageAttacked/255;
rotationImageAttacked=rotationImageAttacked/255;
shearImageAttacked=shearImageAttacked/255;

% Calulating PSNR of Each imaged compared to the Original Image
P1=psnr(watermarked_image,I);
P2=psnr(noiseImageAttacked,watermarked_image);
P3=psnr(imresize(cropImageAttacked,[512 512]),watermarked_image);  
P4=psnr(meanImageAttacked,watermarked_image);
P5=psnr(medianImageAttacked,watermarked_image);
P6=psnr(rotationImageAttacked,watermarked_image);
P7=psnr(imresize(shearImageAttacked,[512 512]),watermarked_image);

psnr_of_watermarked_signal=P1

psnrvalue=[P2;P3;P4;P5;P6;P7];

Attack={'Noise';'Crop';'Mean';'Median';'Rotation';'Shear'};

%Shows Various Attacks and their psnr with respect to the original Image
Table1=table(Attack,psnrvalue)

%Correlation 
C=corr2( extracted_logo , ax )

%structural similarity SSIM
ssimval = ssim( extracted_logo , ax ) 











%% Mathematical Morphology
% codigo clase 18/05/22.

%Lee una imagen especifica de la computadora y la pasa a figure en matlab.
%Convierte la variable a doble precisi�n y la funcion imresize cambia el
%tama�o de la imagen, en este caso escalandola a 0.25, despues se
%inicializa la figura mostrando una imagen en una escala de grises y se
%especifica el rango de visualizacion 
f=imread('radiograph2.jpg'); 
f=double(f(:,:,1)); 
f=f/max(max(f));
f=imresize(f,0.25);
figure(1) 
imshow(f,[]);
title('Radiograph') 
%% Dilatation

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. Con la funcion imdilate dilata la
%imagen en una escala de grises, se puede ver menos visible la imagen
%conforme subas el SE.
se = strel('disk',8); 
BW2 = imdilate(f,se);
imshow(BW2)
title('Dilatation')
% Use different disk size
%% Erosion

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. Con la funcion imerode erosiona la
%imagen en una escala de grises. En este caso se hace un subplot para que
%muestre la imagen erosionada junto con la imagen de la funcion imopen 
se = strel('disk',10); %ten�a 5
BW3 = imerode(f,se);
%imshow(BW3), title('Eroded')
% Use different disk size
%imshowpair(BW2,BW3,'montage')
%title('eroded')

subplot(1,2,1),imshow(BW3),title('Eroded');hold  on
subplot(1,2,2),imshowpair(BW2,BW3,'montage'),title('Montage');hold off
%% Opening

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. La funcion imopen consiste en una
%erosi�n seguida de una dilataci�n utilizando SE, despues se muestra la
%imagen erosionada y dilatada con un titulo.
se = strel('disk',12); %ten�a 7
BW2 = imopen(f,se);
figure(2)
imshow(BW2)
title('Opening')
% Use different disk size
%% Closing

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. La funcion imclose es lo contrario de
%imopen ya que consiste en primero la dilatacion seguida de una erosion
%utilizando SE, despues se  muestra la imagen dilatada y erosionada con un titulo.
se = strel('disk',15); %ten�a 7 
BW2 = imclose(f,se);
imshow(BW2)
title('Closing')
% Use different disk size
%HEAD

%% Gradient SEBAS

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. 
se = strel('disk',1);
BW1 = imdilate(f,se) - imerode(f,se);
imshow(BW1), title('Gradient')
% Use different disk size

%% Preprocess the Image The Rice Matlab Example
% Read an image into the workspace.

%Lee una imagen especifica en este caso del directorio de archivos de
%imagen ya que es .tif y la pasa a figure en matlab.
I = imread('pout.tif');
imshow(I)
title('Pout image')
%% MARIELY/SEBAS
% The background illumination is brighter in the center of the image than at 
% the bottom. Preprocess the image to make the background illumination more uniform.
% 
% As a first step, remove all of the foreground (rice grains) using morphological 
% opening. The opening operation removes small objects that cannot completely 
% contain the structuring element. Define a disk-shaped structuring element with 
% a radius of 15, which fits entirely inside a single grain of rice.

se = strel('disk',15)
%% MARIELY/SEBAS

% To perform the morphological opening, use |imopen| with the structuring element.

background = imopen(I,se);
imshow(background)
title('Opening')
%% MARIELY/SEBAS

% Subtract the background approximation image, |background|, from the original 
% image, |I|, and view the resulting image. After subtracting the adjusted background 
% image from the original image, the resulting image has a uniform background 
% but is now a bit dark for analysis.

I2 = I - background;
imshow(I2)
title('Background')
%%

%Se utiliza la funcion imadjust para aumentar el contraste de nuestra
%imagen procesada.
I3 = imadjust(I2)
imshow(I3)
title('Foto ajustada')
%% 
% Note that the prior two steps could be replaced by a single step using |imtophat| 
% which first calculates the morphological opening and then subtracts it from 
% the original image.
% 
% I2 = imtophat(I,strel('disk',15));|
%% 

% Se utiliza la funcion imbinarize para convertir la figure de una escala
% de grises a una imagen binaria. La funcion bwareaopen elimina el ruido
% del fondo de la imagen.
bw = imbinarize(I3);
bw = bwareaopen(bw,10);
imshow(bw)
title('Binary image')

% Use different size of the structural element

%% Skeletonize 2-D Grayscale Image
% Read a 2-D grayscale image into the workspace. Display the image. Objects 
% of interest are dark threads against a light background.

%Lee una imagen especifica de la computadora y la pasa a figure en matlab.
%Para el caso de Skeletonize se utiliza una imagen en una escala de grises
%donde el background es negro y el foreground es blanco.
I = imread('Skeletonize.jpg');
imshow(I)
%% 
% Skeletonization requires a binary image in which foreground pixels are |1| 
% (white) and the background is |0| (black). To make the original image suitable 
% for skeletonization, take the complement of the image so that the objects are 
% light and the background is dark. Then, binarize the result.


Icomplement = imcomplement(I);
BW = imbinarize(Icomplement);
imshow(BW)
%% 
% Perform skeletonization of the binary image using |bwskel|.

out = bwskel(BW);
%% 
% Display the skeleton over the original image by using the |labeloverlay| function. 
% The skeleton appears as a 1-pixel wide blue line over the dark threads.

imshow(labeloverlay(I,out,'Transparency',0))
%% 
% Prune small spurs that appear on the skeleton and view the result. One short 
% branch is pruned from a thread near the center of the image.

out2 = bwskel(BW,'MinBranchLength',15);
imshow(labeloverlay(I,out2,'Transparency',0))
%Play with the size of Min Branch Lenght

%% The alternative method with bwmorph

BW3 = bwmorph(BW,'skel',Inf);
figure
imshow(BW3)
%% Lets play with the x-ray SEBAS

se = strel('disk',7);
BW3 = f-imopen(f,se);
imshow(BW3,[])
bw = imbinarize(BW3);
imshow(bw,[])
bw = imopen(bw,strel('disk',1));
bw = imclose(bw,strel('disk',3));
imshow(bw,[])
bw = bwareaopen(bw,50);
imshow(bw,[])
BW3 = bwmorph(bw,'skel',Inf);
imshow(BW3)
imshow(labeloverlay(f,BW3,'Transparency',0))

% Do the same with your own image
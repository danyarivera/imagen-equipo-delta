%% Mathematical Morphology
% código clase 18/05/22.

%Lee una imagen especifica de la computadora y la pasa a figure en matlab.
%Convierte la variable a doble precisión y la función imresize cambia el
%tamaño de la imagen, en este caso escalándola a 0.25, después se
%inicializa la figura mostrando una imagen en una escala de grises y se
%especifica el rango de visualización

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
figure(2)
imshow(BW2)
title('Dilatation')
% Use different disk size
%% Erosion

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. Con la funcion imerode erosiona la
%imagen en una escala de grises. En este caso se hace un subplot para que
%muestre la imagen erosionada junto con la imagen de la funcion imopen 
se = strel('disk',10); %tenÃ­a 5
BW3 = imerode(f,se);
%imshow(BW3), title('Eroded')
% Use different disk size
%imshowpair(BW2,BW3,'montage')
%title('eroded')
figure(3)
subplot(1,2,1),imshow(BW3),title('Eroded');hold  on
subplot(1,2,2),imshowpair(BW2,BW3,'montage'),title('Montage');hold off
%% Opening

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. La funcion imopen consiste en una
%erosiÃ³n seguida de una dilataciÃ³n utilizando SE, despues se muestra la
%imagen erosionada y dilatada con un titulo.
se = strel('disk',12); %tenÃ­a 7
BW2 = imopen(f,se);
figure(4)
imshow(BW2)
title('Opening')
% Use different disk size
%% Closing

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. La funcion imclose es lo contrario de
%imopen ya que consiste en primero la dilatacion seguida de una erosion
%utilizando SE, despues se  muestra la imagen dilatada y erosionada con un titulo.
se = strel('disk',15); %tenÃ­a 7 
BW2 = imclose(f,se);
figure(5)
imshow(BW2)
title('Closing')
% Use different disk size
%HEAD

%% Gradient SEBAS

%El strel crea un elemento estructurante (SE) el cual asume valores binarios y
%puede ser en 2D como en este caso. 
se = strel('disk',1);
BW1 = imdilate(f,se) - imerode(f,se);
figure(6)
imshow(BW1), title('Gradient')
% Use different disk size

%% Preprocess the Image The Rice Matlab Example
% Read an image into the workspace.

%Lee una imagen especifica en este caso del directorio de archivos de
%imagen ya que es .tif y la pasa a figure en matlab.
I = imread('pout.tif');
figure(7)
imshow(I)
title('Pout image')
%% BACKGROUND ILUMINATION

%  Preprocesar la imagen para hacer la iluminación de fondo más uniforme.
%Define la forma del disco en un radio de 15 cm el cual encaja perfectamente en un grano de arroz                               
se = strel('disk',15)

%Abre la imagen de forma morfológica

background = imopen(I,se);
figure(8)
imshow(background)
title('Opening')
%% BACKGROUND SUBSTRACTION
% Se sustrae el fondo de la imagen original para un resultado más uniforme
% pero algo oscuro para su análisis.

I2 = I - background;
figure(9)
imshow(I2)
title('Background')
%%

%Se utiliza la funcion imadjust para aumentar el contraste de nuestra
%imagen procesada.
I3 = imadjust(I2)
figure(10)
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
figure(11)
imshow(bw)
title('Binary image')

% Use different size of the structural element

%% Skeletonize 2-D Grayscale Image

%Lee una imagen especifica de la computadora y la pasa a figure en matlab.
%Para el caso de Skeletonize se utiliza una imagen en una escala de grises
%donde el background es negro y el foreground es blanco.
I = imread('Skeletonize.jpg');
figure(13)
imshow(I)
title('Grayscale')
%% 

%Para este paso se toma el complemento de la imagen para que los objetos
%sean claro y el fondo es oscuro. Despues se binariza el resultado. 
Icomplement = imcomplement(I);
BW = imbinarize(Icomplement);
figure(14)
imshow(BW)
title('Binary image')
%% 

%La funcion bwskel reduce los objetos de la imagen binaria a lineas curvas
%sin cambiar la estructura original de la imagen.
out = bwskel(BW);
%% 

%El esqueleto de color azul se vera reflejado sobre la imagen original
%usando el filtro labeloverlay. El esqueleto esta sobre el fondo oscuro y
%tiene un pixel de ancho.
figure(15)
imshow(labeloverlay(I,out,'Transparency',0))
title('Width Pixel')
%% 
% Remueve pequeños trozos que aparecen en la imagen, se lleva a cabo en un pedazo 
% pequeño del centro
out2 = bwskel(BW,'MinBranchLength',15);
figure(16)
imshow(labeloverlay(I,out2,'Transparency',0))
title('Min Branch lenght')
%Play with the size of Min Branch Lenght

%% The alternative method with bwmorph

%La funcion bwmorph se utiliza para aplicar una operacion morfologica
%especifica en la imagen binaria el cual 'skel' es la operacion el cual
%permite eliminar pixeles de los limites de los objetos. Y sigue Inf que es
%el numero de veces en el que se lleva a cabo en la operacion.
BW3 = bwmorph(BW,'skel',Inf);
figure(17)
imshow(BW3)
title('Bwmorph method')
%% Lets play with the x-ray

se = strel('disk',7);
BW3 = bwmorph(bw,'skel',Inf);
imshow(BW3)
imshow(labeloverlay(f,BW3,'Transparency',0))
BW3 = f-imopen(f,se);
figure(18)
imshow(BW3,[])
bw = imbinarize(BW3);
figure(19)
imshow(bw,[])
bw = imopen(bw,strel('disk',1));
bw = imclose(bw,strel('disk',3));
figure(20)
imshow(bw,[])
bw = bwareaopen(bw,50);
figure(21)
imshow(bw,[])
BW3 = bwmorph(bw,'skel',Inf);
figure(22)
imshow(BW3)
figure(23)
imshow(labeloverlay(f,BW3,'Transparency',0))


% Do the same with your own image
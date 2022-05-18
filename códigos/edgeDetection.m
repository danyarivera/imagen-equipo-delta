f=imread('radiograph1.jpg'); %Lee una imagen especifica de la computadora y la pasa a figure en matlab
f=imresize(f,0.25); %El imresize cambia el tamaño de la imagen, en este caso escalandola a 0.25
f=double(f(:,:,1)); %
imshow(f,[]) % Muestra la imagen en una escala de grises y se especifica el rango de visualización

%%
edgex=[1,-1] %Crea un arreglo del borde x
g1=conv2(f,edgex,'same'); %Devuelve una sección de la convolución, en este caso el centro. (Borde X)
imshow(g1,[-10,10]); % Muestra una imagen en escala de grises con rango de visualización de -10 a 10 de la conv2.
%%
edgey=[-1 -2 -1;0,0,0;1,2,1]/8
g2=conv2(f,edgey,'same');
imshow(g2,[-10,10])
figure(2)
subplot(1,2,1)
imshow(g1,[-10,10])
subplot(1,2,2)
imshow(g2,[-10,10])
%%
figure(3)
subplot(1,1,1)
%%
edgex=[1,0,-1;2,0,-2;1,0,-1]/8
gx=conv2(f,edgex,'same');
gy=conv2(f,edgey,'same');
mag=abs(gx)+abs(gy);
imshow(mag,[]);
%%
noisemask = [-1, 0 1];
noiseimage = conv2(f,noisemask,'same');
noisevariance = mean2(noiseimage.^2);
noisestd = sqrt(noisevariance/2);
edgedetection1 = mag > noisestd;
edgedetection2 = mag > 2*noisestd;
subplot(1,2,1)
imshow(edgedetection1,[]);
subplot(1,2,2)
imshow(edgedetection2,[]);
figure(4)
subplot(1,1,1)
angle=atan2(gy,gx);
imshow(angle,[]);
%%
edgcany=edge(f,'Canny');
imshow(edgcany,[]);
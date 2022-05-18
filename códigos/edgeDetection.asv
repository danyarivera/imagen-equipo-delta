f=imread('radiograph1.jpg');
f=imresize(f,0.25);
f=double(f(:,:,1));
imshow(f,[])
%%
edgex=[1,-1]
g1=conv2(f,edgex,'same');
imshow(g1,[-10,10]);
%% 
edgey=[-1 -2 -1;0,0,0;1,2,1]/8 % Crea un arreglo del borde Y
g2=conv2(f,edgey,'same'); % Devuelve una sección de la convolución, en este caso el centro. (Borde Y)
imshow(g2,[-10,10]) % Muestra una imagen en scala de grises con rango de visualización de -10 a 10 de la convolución central.
figure(2) % Inicializa otra figura para que no se borre la anterior
subplot(1,2,1) % Divide la figure(2) en cuadrículas (subgráficas)
imshow(g1,[-10,10]) % Muestra una imagen en scala de grises con rango de visualización de -10 a 10 de la convolución central.
subplot(1,2,2) % Divide la figure(2) en cuadrículas (subgráficas)
imshow(g2,[-10,10]) % Muestra una imagen en scala de grises con rango de visualización de -10 a 10 de la convolución central.
%%
figure(3)
subplot(1,1,1)
%%
edgex=[1,0,-1;2,0,-2;1,0,-1]/8  % Crea un areglo del borde x 
gx=conv2(f,edgex,'same'); %Devuelve una sección de la convolución, en este caso del centro (Borde x)
gy=conv2(f,edgey,'same');%Devuelve una sección de la convolución, en este caso del centro (Borde y)
mag=abs(gx)+abs(gy); %Suma de los absolutos para obtener su magnitud
imshow(mag,[]); %Muestra la imagen en escala de grises
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
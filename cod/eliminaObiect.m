function img = eliminaObiect(img,ploteazaDrum,culoareDrum)

imgInitiala = img;
imshow(img)
rect = getrect;
close(gcf);
xmin = round(rect(1, 1));
ymin = round(rect(1, 2));
xmax = round(rect(1, 3) + rect(1, 1));
ymax = round(rect(1, 4) + rect(1, 2));
if xmin <= 0
    xmin = 1;
end
if ymin <= 0
    ymin = 1;
end
[y, x, c] = size(img);
if x < xmax
    xmax = x;
end
if y < ymax
    ymax = y;
end

%imgRedimensionata;

if (xmax - xmin) <= (ymax - ymin)
    img = micsoreazaLatimeEliminaObiect(img, ploteazaDrum, culoareDrum, xmin, ymin, xmax, ymax);
    imgRedimensionata(:,1:xmin,:) = imgInitiala(:,1:xmin,:);
    imgRedimensionata(:,xmin:x - (xmax - xmin),:) = imgInitiala(:,xmax:x,:);
else
    img = imrotate(img, 90);
    img = micsoreazaLatimeEliminaObiect(img, ploteazaDrum, culoareDrum, ymin, x - xmax, ymax, x - xmin);
    img = imrotate(img, 270);
    imgRedimensionata(1:ymin,:,:) = imgInitiala(1:ymin,:,:);
    imgRedimensionata(ymin:y - (ymax - ymin),:,:) = imgInitiala(ymax:y,:,:);
end

%ploteaza imaginile obtinute
figure, hold on;

%1. imaginea initiala
h1 = subplot(1,3,1);imshow(imgInitiala);
xsize = get(h1,'XLim');ysize = get(h1,'YLim');
xlabel('imaginea initiala');

%2. imaginea redimensionata cu pastrarea continutului
h2 = subplot(1,3,2);imshow(img);
set(h2, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul nostru');

%3. imaginea obtinuta prin redimensionare traditionala
h3 = subplot(1,3,3);imshow(imgRedimensionata);
set(h3, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul imresize');

imwrite(imgInitiala,'lac.jpg');
imwrite(img,'lac1.jpg');
imwrite(imgRedimensionata,'lac2.jpg');
%Implementarea a proiectului Redimensionare imagini
%dupa articolul "Seam Carving for Content-Aware Image Resizing", autori S.
%Avidan si A. Shamir 
%%
%aceasta functie ruleaza intregul proiect 
%setati parametri si imaginile de redimensionat aici

%citeste o imagine
img = imread('../data/test.jpg');

%reducem imaginea in latime cu 20 de pixeli
%seteaza parametri
parametri.optiuneRedimensionare = 'micsoreazaInaltime';
parametri.numarPixeliLatime = 50;
parametri.numarPixeliInaltime = 50;
parametri.ploteazaDrum = 0;
parametri.culoareDrum = [255 0 0]';%culoarea rosie
parametri.metodaSelectareDrum = 'aleator';%optiuni posibile: 'aleator','greedy','programareDinamica'


imgRedimensionata_proiect = redimensioneazaImagine(img,parametri); 

%foloseste functia imresize pentru redimensionare traditionala
imgRedimensionata_traditional = imresize(img,[ size(imgRedimensionata_proiect,1) size(imgRedimensionata_proiect,2)]);

if strcmp(parametri.optiuneRedimensionare,'eliminaObiect') == 0
    %ploteaza imaginile obtinute
    figure, hold on;

    %1. imaginea initiala
    h1 = subplot(1,3,1);imshow(img);
    xsize = get(h1,'XLim');ysize = get(h1,'YLim');
    xlabel('imaginea initiala');

    %2. imaginea redimensionata cu pastrarea continutului
    h2 = subplot(1,3,2);imshow(imgRedimensionata_proiect);
    set(h2, 'XLim', xsize, 'YLim', ysize);
    xlabel('rezultatul nostru');

    %3. imaginea obtinuta prin redimensionare traditionala
    h3 = subplot(1,3,3);imshow(imgRedimensionata_traditional);
    set(h3, 'XLim', xsize, 'YLim', ysize);
    xlabel('rezultatul imresize');
    
    imwrite(img,'nightInitial.jpg');
    imwrite(imgRedimensionata_proiect,'nightAleator.jpg');
    imwrite(imgRedimensionata_traditional,'nightTraditional.jpg');
end

% a)
% 1) calculez gradientii: imgradient / imfilter(F,fx) => alb-negru
% E(x, y) = gradient(x, y)
% 2) M matrice de drumuri 
% M(x, y) = costul celui mai "ieftin" drum fare leaga partea de sus cu (x, y) = E(x, y) + min(M(x - 1, y - 1), M(x - 1, y), M(x - 1, y + 1))
% imagesc(M)
% 3) eliminati drumul respectiv
% d = [1 15]
%     [2 14]
%     [3 15]
% eliminaDrumVertical(img)
%  H * (W - 1)        H * W

% b)
% intoarcem imaginea la 90 grade

% c)
% luam cele mai mici n drumuri si le tinem minte
% medie intre drumul din minim si cel stanga, iar apoi cel din dreapta

% d)
% a = getrect();
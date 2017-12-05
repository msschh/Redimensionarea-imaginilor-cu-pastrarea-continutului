function img = micsoreazaLatimeEliminaObiect(img,ploteazaDrum,culoareDrum,xmin,ymin,xmax,ymax)

numarPixeliLatime = xmax - xmin + 1;

for i = 1:numarPixeliLatime
    
    disp(['Eliminam drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
    %alege drumul vertical care conecteaza sus de jos
    drum = selecteazaDrumVerticalEliminaObiect(E,xmin,ymin,xmax,ymax);
    
    %afiseaza drum
    if ploteazaDrum
        ploteazaDrumVertical(img,E,drum,culoareDrum);
        pause(1);
        close(gcf);
    end
    
    %elimina drumul din imagine
    img = eliminaDrumVertical(img,drum);
    xmax = xmax - 1;

end
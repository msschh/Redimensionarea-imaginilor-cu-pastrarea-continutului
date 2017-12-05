function d = selecteazaDrumVerticalEliminaObiect(E,xmin,ymin,xmax,ymax)

d = zeros(size(E,1),2);

[N, M] = size(E);
matriceDistanta = Inf(N, M);
for i = 1:N
    for j = 1:M
        if ymin <= i && i <= ymax && (j < xmin || j > xmax)
        else
            if i == 1
                matriceDistanta(i,j) = E(i,j);
            elseif j == 1
                matriceDistanta(i,j) = E(i,j) + min(matriceDistanta(i - 1,j), matriceDistanta(i - 1, j + 1));
            elseif j == M
                matriceDistanta(i,j) = E(i,j) + min(matriceDistanta(i - 1,j), matriceDistanta(i - 1, j - 1));
            else
                matriceDistanta(i,j) = E(i,j) + min([matriceDistanta(i - 1, j - 1), matriceDistanta(i - 1, j), matriceDistanta(i - 1, j + 1)]);
            end
        end
    end
end

[~, j] = min(matriceDistanta(N, :));

for i=N:-1:2
    d(i, :) = [i j];
    if j == 1
        if matriceDistanta(i,j) ~= E(i,j) + matriceDistanta(i-1,j)
            j = j + 1;
        end
    elseif j == M
        if matriceDistanta(i,j) ~= E(i,j) + matriceDistanta(i-1,j)
            j = j - 1;
        end
    else
        if matriceDistanta(i,j) == E(i,j) + matriceDistanta(i-1,j-1)
            j = j - 1;
        elseif matriceDistanta(i,j) == E(i,j) + matriceDistanta(i-1,j+1)
            j = j + 1;
        end
    end
end
d(1, :) = [1 j];
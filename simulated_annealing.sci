//Griewank function
function z=f(x, y)
    z = (x^2)/50 + (y^2)/50 - (cos(x)+1)*(cos(y/sqrt(2))+1);
endfunction

//plotting
x = linspace(-15,15,100);
y = linspace(-15,15,100);
z = feval(x,y,f);
surf(x,y,z);

//simulated annealing algo
x = -1.2; y = 1; //initial solution
T = 2.5; //initial temperature
iter = 0;
x_best = -1,2; y_best = 1; //best solution
n = 2;

    while T > 0.0001
        while iter < 1000
            x_vois = x + ((rand(1,1,"uniform")-rand(1,1,"uniform"))*n); //trouve un voisinage de x
            y_vois = y + ((rand(1,1,"uniform")-rand(1,1,"uniform"))*n); //trouve un voisinage de y
            
            Delta = f(x_vois,y_vois) - f(x,y);
            
            if Delta < 0 then //si le voisinage est meilleur, l'accepté
                x = x_vois; y = y_vois;
            
            if f(x_best,y_best) - f(x,y) > 0 then //garder la meilleure solution trouvée
                x_best = x; y_best = y;
            end
            else
                p = (rand(1,1,"uniform"));
                if p < exp(-Delta/T) then //accepter le point voisin meme si il n'est
                    x = x_vois; y = y_vois; //pas meilleur avec la probabilité p
                end
            end
        iter = iter+1;
        end
        T = 0.99*T; //décroissance de la température
        n = 0.99*n; //décroisance du pas de recherche du voisin
        iter = 0;
    end
disp(x_best);
disp(y_best);
disp(f(x_best,y_best));

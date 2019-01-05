//   Methode de recuit simule PASA
///////////////////////////////////////////////////////////////
// definition de la fonction a minimiser

function z=f(x)  // the function to optimize
    z(1)= x;
    z(2)= (cos(x))^2;
endfunction

xmin = 0;
xmax = 4;

function z=feq(x)  // fonction d'agregation
    w = f(x);
    z = log(w(1))+log(w(2));
endfunction

///////////////////////////////////////////////////////////////
// fonction Voisin

function y = voisin(x)  
a = 1/2*(rand(1,1,"uniform")-rand(1,1,"uniform"));
y = x + a;

if y < xmin || y > xmax then
    y = x - a;
end
endfunction

///////////////////////////////////////////////////////////////
// fonction de dominance

function z = domine(x,y)
    a = f(x);
    b = f(y);
    z = 0;

if a(1) <= b(1) && a(2) < b(2)then
    z = 1;
elseif a(1) < b(1) && a(2) <= b(2)then
    z = 1;
end
endfunction


////////////////////////////////////////////
T0 = 10;
x0 = 3
T = T0;
x = x0;
A = [x];         // archive
alpha = 0.99;

while T > T0*10^(-10)
    for i = 1:50
        y = voisin(x)
        df = feq(y)-feq(x)
        if df < 0 then
            x = y
        elseif exp(-df/T) > rand(1,1,"uniform") then
            x = y
        end
    end

    for i = 1:size(A,2)
        if domine(A(i),x) == 1 then
            break
        elseif domine(x,A(i)) == 1 then
            A(i)= x
        end
     end
     A = unique(A)
     
     compteur = 1
     for i = 1:size(A,2)
        if domine(A(i),x) == 0 && domine(x,A(i))==0 && x~=A(i) then
            compteur = compteur+1
        end
     end
     if compteur == size(A,2)+1 then
         A=[A,x]
     end
     
     x = A(size(A,2))//return to base
     T = alpha*T
end


///////////////////////////////////////////////////////////////
x = linspace(0,4,100);
y = (cos(x))^2;
plot(x,y,"r")
xlabel("f1")
ylabel("f2")
for i = 1:size(A,2)
    a = f(A(i))
plot(a(1),a(2),'.')
end
/////////////////////////////////////////////////////////////

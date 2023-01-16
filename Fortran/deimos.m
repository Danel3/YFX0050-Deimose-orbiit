andmed = load("deimos.txt");
%{
plot(andmed(:,2), andmed(:,3));
title("Deimose orbiit")
xlabel('Asukoha x komponent: r_x [km]') 
ylabel('Asukoha y komponent: r_y [km]')
pbaspect([1 1 1])
%}
%{
plot(andmed(:,4), andmed(:,5))
title("Deimose kiiruse projektsioon")
xlabel('Kiiruse x komponent: v_x [km/s]') 
ylabel('Kiiruse y komponent: v_y [km/s]')
pbaspect([1 1 1])
%}

plot(andmed(:,1), andmed(:,6))
title("Deimose kauguse moodul ajas")
xlabel('Aeg: t [s]') 
ylabel('Kaugus: r [km]')

%{
plot(andmed(:,1), andmed(:,7))
title("Deimose kiiruse moodul ajas")
xlabel('Aeg: t [s]') 
ylabel('Kiirus: v [km/s]')
%}
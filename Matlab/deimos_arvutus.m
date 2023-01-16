clear
global m_mars G
%Gravitatsioonikonstant
G = 6.67408e-11;

%Gravitatsiooni konstant
G=6.67408e-11;
%Marsi andmed
m_mars = 6.4219e+23;
r_mars = 3375;
%Deimose andmed 
m_deimos = 1.4762e+15;
r_deimos = 6.2;
v_deimos = 1.3513;

r = 23463.2;
y0=[r;0.;0.;v_deimos];

options = odeset('RelTol',1e-8,'AbsTol',1e-8,'MaxStep',100.,'InitialStep',1.);
[t,y]=ode45(@func,[0,400000],y0,options);

r_abs=sqrt(y(:,1).^2+y(:,2).^2);
v_abs=sqrt(y(:,3).^2+y(:,4).^2);

subplot(2,2,1)
plot(y(:,1), y(:,2));
title("Deimose orbiit")
xlabel('Asukoha x komponent: r_x [km]')
ylabel('Asukoha y komponent: r_y [km]')
pbaspect([1 1 1])
grid on

subplot(2,2,2)
plot(y(:,3), y(:,4));
title("Deimose kiiruse projektsioon")
xlabel('Kiiruse x komponent: v_x [km/s]') 
ylabel('Kiiruse y komponent: v_y [km/s]')
pbaspect([1 1 1])
grid on

subplot(2,2,3)
plot(t, r_abs)
title("Deimose kauguse moodul ajas")
xlabel('Aeg: t [s]') 
ylabel('Kaugus: r [km]')
grid on

subplot(2,2,4)
plot(t, v_abs)
title("Deimose kiiruse moodul ajas")
xlabel('Aeg: t [s]') 
ylabel('Kiirus: v [km/s]')
grid on


function dy = func(t,y)
    global m_mars G
    rr =sqrt(y(1)^2+y(2)^2);
    dy = zeros(4,1);
    dy(1) = y(3);
    dy(2) = y(4);
    dy(3) = -G*m_mars*1.e-9*y(1)/rr^3;
    dy(4) = -G*m_mars*1.e-9*y(2)/rr^3;
end


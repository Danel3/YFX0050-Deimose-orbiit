implicit real*8(a-h,o-z)
real*8 work(184),y(4),m_mars,m_deimos
integer iwork(5)
common gm
external func
!Fail tulemuste salvestamiseks
open(10,file="deimos.txt")

!Gravitatsiooni konstant
G=6.67408e-11
!Marsi andmed
m_mars = 6.4219e+23 !kg
r_mars = 3375 !km
!Deimose andmed 
m_deimos = 1.4762e+15 !kg
r_deimos = 6.2 !km
v_deimos = 1.3513 !km/s
!
gm=G*m_mars
!Keskmine kaugus Marsi massikeskmest Deimose massikeskmeni
r = 23463.2!km
!Vahemaa ja kiiruse komponentide massiiv
y(1) = r        !rx kauguse x komponent [km]
y(2) = 0.       !ry kauguse y komponent [km]
y(3) = 0.       !vx kiiruse x komponent [km/s]
y(4) = v_deimos !vy kiiruse y komponent [km/s]


! ode.f jaoks vajalikud andmed
t=0.          !Aja algväärtus
dt=1.         !Ajasamm
relerr=1.e-6  !Relatiivne arvutusviga
abserr=1.e-6  !Absoluutne arvutusviga
nt=200000     !Ajasammude arv
iflag=1       !ode.f oleku lipp
neqn=4        !Dif. võrrandite arv

!Tsükkel väärtuste leidmiseks eri ajahetkedel
do i=1,nt
  tout=t+dt
  call ode(func,neqn,y,t,tout,relerr,abserr,iflag,work,iwork)
  if(iflag.ne.2)then
    iflag=2
  endif
  !kauguse ja kiiruse moodulid
  r_abs=sqrt(y(1)**2+y(2)**2)
  v_abs=sqrt(y(3)**2+y(4)**2)
  !Väljundandmed: t, rx, ry, vx, vy, r_abs, v_abs
  write(10,*) tout, y, r_abs, v_abs
enddo
stop
end

!Alamprogramm diferentsiaal võrrandite defineerimiseks
subroutine func(t,y,dy)
  implicit real*8(a-h,o-z)
  real*8 y(4),dy(4), rr
  common gm
  !Kaugus
  rr = sqrt(y(1)**2+y(2)**2)*1.e+3
  dy(1)=y(3)
  dy(2)=y(4)
  dy(3)=-gm*y(1)/(rr**3)
  dy(4)=-gm*y(2)/(rr**3)
  return
end subroutine

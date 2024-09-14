import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("panel data") firstrow
encode n, gen(n1)
xtset n1 t
gen lnwage=ln(wage)
gen lnunem= ln(Unemployed)
gen lnDP=lnDep*lnPCI
gen lnDM=lnDep*lnMigration
gen LFP=lnPFDI*lnPCI
gen LFHC=lnPFDI*lnHC
reg lnPGDP lnPDI lnPFDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI///POLS
reg lnPGDP lnPDI lnPFDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP
xtreg lnPGDP lnPFDI lnPDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP///random effects
xttest0///Breusch-Pagan test
xtivreg lnPGDP lnPDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)///IV-1
hausman, save
xtreg lnPGDP lnPFDI lnPDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP
hausman, sigmamore
///Hausman test
ssc install xtoverid
xtivreg lnPGDP lnPDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
xtoverid, robust cluster(n1)///Sargan test
clear
///Shapley value decomposition
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2015") firstrow
reg PGDP PDI PFDI TO HC DE Migration Urbanisation Dep PCI
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP///inequality indices 
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2016") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2017") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2018") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2019") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2020") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2021") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("2022") firstrow
foreach v of var * { 
drop if missing(`v') 
}
db rbdineq
rbdineq PGDP, indcon(PDI PFDI TO HC DE Migration Urbanisation Dep PCI) hsize(pop) dregres(0)
cap ssc install ineqdec0
ineqdec0 PGDP
ineqdec0 PFDI
clear
///Economic growth theory
import excel "C:\Users\thanh\OneDrive - University of Leeds\Desktop\dissertation\panel data.xlsx", sheet("panel data") firstrow
encode n, gen(n1)
xtset n1 t
rename n1 province
by province: gen popgrowth=ln(pop)-ln(pop[_n-1])
gen x1= popgrowth+0.05
gen lngrow=ln(popgrowth)
///g+delta=0.05 (sum of tech growth rate and capital depreciation)
gen lnx1=ln(x1)
generate newvar1 = lnPGDP-L.lnPGDP
///Absolute convergence
reg newvar1 L.lnPGDP
xtreg newvar1 L.lnPGDP
testparm L.lnPGDP
display -ln(1+_b[L.lnPGDP])///convergence speed
display ln(0.5)/ln(1+_b[L.lnPGDP])//half-life time
///Conditional convergence
xtreg newvar1 L.lnPGDP lns1 lnx1 DE
xtreg newvar1 L.lnPGDP lns1 lnx1 DE lnPFDI
///hausman test
xtivreg newvar1 L.lnPGDP lns1 lnx1 DE (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
hausman, save
xtreg newvar1 L.lnPGDP lns1 lnx1 DE lnPFDI
hausman 
///Sargan test
xtivreg newvar1 L.lnPGDP lns1 lnx1 DE (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
xtoverid, robust cluster(province)
///
xtreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnPFDI lnDP
xtivreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
///Hausman
xtivreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
hausman, save
xtreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnPFDI lnDP
hausman, sigmamore
///Half-life time/conditional
xtreg newvar1 L.lnPGDP lns1 lnx1 DE
display -ln(1+_b[L.lnPGDP])///convergence speed
display ln(0.5)/ln(1+_b[L.lnPGDP])//half-life time
xtreg newvar1 L.lnPGDP lns1 lnx1 DE lnPFDI
display -ln(1+_b[L.lnPGDP])///convergence speed
display ln(0.5)/ln(1+_b[L.lnPGDP])//half-life time
xtivreg newvar1 L.lnPGDP lns1 lnx1 DE (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
display -ln(1+_b[L.lnPGDP])///convergence speed
display ln(0.5)/ln(1+_b[L.lnPGDP])//half-life time
xtreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnPFDI, robust
display -ln(1+_b[L.lnPGDP])///convergence speed
display ln(0.5)/ln(1+_b[L.lnPGDP])//half-life time
xtivreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)
///sensitivity analysis
///running IV models sensitive to time dummies with t1==1 as 
xtivreg lnPGDP lnPDI lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP t1 (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI)///IV-0
asdoc xtivreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI lnTO L.lnTO lnPDI L.lnPDI lnHC L.lnHC lnDep L.lnDep lnwage lnMigration L.lnMigration lnUrbanisation L.lnUrbanisation DE lnPCI), nested///IV-3
gen id=_n
graph box PGDP, mark(1,mlabel(id))
graph box PFDI, mark(1,mlabel(id))
///hausman
xtivreg newvar1 L.lnPGDP lns1 lnx1 lnTO lnHC lnMigration DE lnUrbanisation lnDep lnPCI lnDP (lnPFDI = L.lnPGDP L.lnPFDI L.lnHC L.lnDep lnwage L.lnMigration L.lnUrbanisation)



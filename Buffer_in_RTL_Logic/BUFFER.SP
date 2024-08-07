*Buffer

.include model.txt
VCC VCC 0 5
VINA INA 0 PULSE(0 5 0N 10N 10N 200n 500N)
*VINB INB 0 PULSE(0 5 0N 10N 10N 200N 400N)
*VINA INA 0 5



RR21 INA BASE21 10K
RR22 VCC OUT	1K
Q21 OUT BASE21 0 NPN

*XNOT1 OUT Out1 NOT
*XNOT2 OUT Out2 NOT
*XNOT3 OUT Out3 NOT
*XNOT4 OUT Out4 NOT
*XNOT5 OUT Out5 NOT
*XNOT6 OUT Out6 NOT
*XNOT7 OUT Out7 NOT
*XNOT8 OUT Out8 NOT
*XNOT9 OUT Out9 NOT
*XNOT10 OUT Out10 NOT
*XNOT11 OUT Out11 NOT
*XNOT12 OUT Out12 NOT



*Measure static power dissipation(average)
.measure tran ivcc avg i(vcc) from 10p to 600n
.measure avgwrs param='-ivcc*5'
*Measure total power dissipation(average)
.measure tran avgpwrt avg power from 10p to 600n

.DC VINA 0 5 0.1
.TRAN 100N	600N
.PRINT TRAN V(OUT)

*=========NOT-RTL==============  
.SUBCKT NOT INA OUT

VCC VCC 0 5
RR21 INA BASE21 10K
RR22 VCC OUT	1K
Q21 OUT BASE21 0 NPN

.ENDS NOT
*===========AND-RTL===============
.SUBCKT AND INA INB OUT

VCC VCC 0 5
RR1	INA BASE 10K
RR2	VCC OUT1 1K
Q1  OUT1 BASE COL NPN
Q2  COL  BASE2 0 NPN
RR3 INB BASE2 10K
XNOT OUT1 OUT NOT

.ENDS AND
*=============NAND-RTL=====================
.SUBCKT NAND INA INB OUT

VCC VCC 0 5
RR1	INA BASE 10K
RR2	VCC OUT 1K
Q1  OUT BASE COL NPN
Q2  COL  BASE2 0 NPN
RR3 INB BASE2 10K

.ENDS NAND
*=============XOR-RTL==============
.SUBCKT XOR INA INB OUT


XNOT1 INB OUT_NOT1 NOT
XNOT2 INA OUT_NOT2 NOT
XNAND1 INA OUT_NOT1 OUT_NAND1 NAND
XNAND2 INB OUT_NOT2 OUT_NAND2 NAND
XNAND3 OUT_NAND1 OUT_NAND2 OUT NAND

.ENDS XOR
*==================================

.END 

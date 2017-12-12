
library ("EBImage")

xef = c(0,5,10,15,20,25,30,35,40)
yef1 = c(1,1,1,.5,0,0,0,0,0)
yef2 = c(0,0,0,0,0,.5,1,1,1)
yef3 = c(0,0,0,.5,1,.5,0,0,0)

plot(xef, yef1, pch=16, type="o", axes=F,col="black", xlim = c(0,40), ylim = c(0,1))
par(new=T)
plot(xef, yef2, col="red", type="o")
par(new=T)
plot(xef, yef3, col="green", type="o")


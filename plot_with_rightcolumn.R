# plot with right column using grid package
# author : Gong Cheng

library(grid)
library(ggplot2)

# 设置绘图区域，默认从绘图区域的左下为绘图原点
vp_left <- viewport(x = 0, y=0, w=0.75, h=1, 
                    just = c("left", "bottom"), 
                    name="vp_left")
vp_right1 <- viewport(x=0.8, y=0, w=0.2, h=0.45, 
                      just = c("left", "bottom"), 
                      name="vp_right1")
vp_right2 <- viewport(x=0.8, y=0.55, w=0.2, h=0.45, just = c("left", "bottom"), name="vp_right2")
# 提前观察设置的绘图网格是否合适
showViewport(vp_left)
showViewport(vp_right1)
showViewport(vp_right2)

# 绘制左边的散点图
fig_left <- ggplot(data=cars, aes(speed, dist)) + geom_point() + geom_smooth() + theme_classic()

qdist <- data.frame(dist = 1, 
                    y0=min(cars$dist),
                    y25=quantile(cars$dist, 0.25),
                    y50=quantile(cars$dist, 0.50),
                    y75=quantile(cars$dist, 0.75),
                    y100=max(cars$dist))
qspeed <- data.frame(speed = 1, 
                     y0=min(cars$speed),
                     y25=quantile(cars$speed,0.25),
                     y50=quantile(cars$speed, 0.5),
                     y75=quantile(cars$speed,0.75),
                     y100=max(cars$speed))
# 绘制右边下方的箱线图
fig_right1 <- ggplot(qdist, aes(dist)) + geom_boxplot(aes(ymin=y0,
                                                          lower=y25,
                                                          middle=y50, 
                                                          upper=y75,
                                                          ymax=y100),
                                                      stat = "identity")
# 将y轴放到右边
fig_right1 <- fig_right1 + scale_y_continuous(position = "right")

# 绘制右边的箱线图
fig_right2 <- ggplot(qspeed, aes(speed)) + geom_boxplot(aes(ymin=y0,
                                                            lower=y25,
                                                            middle=y50, 
                                                            upper=y75,
                                                            ymax=y100),
                                                        stat = "identity")
# 将y轴放到右边
fig_right2 <- fig_right2 + scale_y_continuous(position = "right")

# 设定右边箱线图的主题，去掉x轴轴须，坐标线，轴须标注，去掉背景和网格线
theme_right <- theme(axis.line.y = element_line(colour="black"),
                     axis.ticks.x = element_blank(),
                     axis.text.x = element_blank(),
                     panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(),
                     panel.background = element_blank())

# 应用主题
fig_right1 <- fig_right1 + theme_right
fig_right2 <- fig_right2 + theme_right

# 开启一个绘图装置
grid.newpage()
# 输出到当前绘图装置
print(fig_left, vp=vp_left)
print(fig_right1, vp=vp_right1)
print(fig_right2, vp=vp_right2)
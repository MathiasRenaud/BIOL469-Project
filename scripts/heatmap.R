
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
  library(gplots)
}
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
}

data <- read.csv("~/Downloads/eggNog-annotations/Go-annotations.csv", comment.char="#")
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
matr <- data.matrix(data[,2:ncol(data)])  # transform column 2-5 into a matrix
rownames(matr) <- rnames                 # assign row names

# creates a own color palette from red to green
my_palette <- colorRampPalette(c("tomato", "springgreen3"))(n = 2)
my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 299)

## (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(0,0.9, length=100),  # for red
               seq(1,100, length=100),           # for yellow
               seq(101,3000, length=100))             # for green

# (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(0,  # for tomato
               0.5,
               1)  # for springgreen3


## creates a 5 x 5 inch image
#png("../images/heatmaps_in_r.png",    # create PNG for the heat map        
#    width = 5*300,        # 5 x 300 pixels
#    height = 5*300,
#    res = 300,            # 300 pixels per inch
#    pointsize = 8)        # smaller font size

library(gplots)
heatmap.2(t.matr,
          #cellnote=matr,  # same data set for cell labels
          main="Abundance of GO Terms", # heat map title,
          notecol="black",      # change font color of cell labels to black
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          margins=c(12,9),      # widens margins around plot
          col=my_palette,       # use on color palette defined earlier
          breaks=col_breaks,    # enable color transition at specified limits
          #dendrogram="row",    # only draw a row dendrogram
          #Colv="NA",           # turn off column clustering
          key=TRUE
          #colsep=1:20,
          #rowsep=1:100,
          #sepcolor='black',
          #sepwidth=c(0.00001, 0.00001)
          )

#dev.off()               # close the PNG device
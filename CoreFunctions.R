## This file serves as a script for demonstration of some core funcitons one can execute
## on various biome data!


                                        # draw a heatmap!

                                        # Customize a heatmap!


args = commandArgs(trailingOnly=TRUE)

if (length(args) == 0){
    stop("Enter at least one argument!");    
}


inputfile <- args[1]
percentIdentical <- args[2]
outfile <- args[3]

## make color scheme according to 2
## construct a custom heatmap, which can easily plot different percentages .. according to
## for each, which count with apply(1) < percentidentical, color differently, x - x/2 color differnetly and fianlly
## color the third one differently also!

## if args[3] != null, then simplt save image as png, else just display it!

## end.

# palette(rainbow(6))
# colorRampPalette(c("blue", "red"))( 4) 

if (!require("gplots")) {
    install.packages("gplots", dependencies = TRUE)
    library(gplots)
}
if (!require("RColorBrewer")) {
    install.packages("RColorBrewer", dependencies = TRUE)
    library(RColorBrewer)
}

data <- read.csv(inputfile, comment.char="#")
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[,2:ncol(data)])  # transform column 2-5 into a matrix
rownames(mat_data) <- rnames                  # assign row names

                                        # creates a own color palette from red to green
my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 299)

                                        # (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(-1,0,length=100),  # for red
               seq(0.01,0.8,length=100),           # for yellow
               seq(0.81,1,length=100))             # for green

                                        # creates a 5 x 5 inch image

if (outfile != null)}{
    png(paste("slike/",outfile),    # create PNG for the heat map        
        width = 5*300,        # 5 x 300 pixels
        height = 5*300,
        res = 300,            # 300 pixels per inch
        pointsize = 8)        # smaller font size

    heatmap.2(mat_data,
              cellnote = mat_data,  # same data set for cell labels
              main = "Correlation", # heat map title
              notecol="black",      # change font color of cell labels to black
              density.info="none",  # turns off density plot inside color legend
              trace="none",         # turns off trace lines inside the heat map
              margins =c(12,9),     # widens margins around plot
              col=my_palette,       # use on color palette defined earlier
              breaks=col_breaks,    # enable color transition at specified limits
              dendrogram="row",     # only draw a row dendrogram
              Colv="NA")            # turn off column clustering

    dev.off()  
}else{

    heatmap.2(mat_data,
              cellnote = mat_data,  # same data set for cell labels
              main = "Correlation", # heat map title
              notecol="black",      # change font color of cell labels to black
              density.info="none",  # turns off density plot inside color legend
              trace="none",         # turns off trace lines inside the heat map
              margins =c(12,9),     # widens margins around plot
              col=my_palette,       # use on color palette defined earlier
              breaks=col_breaks,    # enable color transition at specified limits
              dendrogram="row",     # only draw a row dendrogram
              Colv="NA")            # turn off column clustering


}

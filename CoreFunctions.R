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


set.seed(88)


if (!require("gplots")) {
    install.packages("gplots", dependencies = TRUE)
    library(gplots)
}
if (!require("RColorBrewer")) {
    install.packages("RColorBrewer", dependencies = TRUE)
    library(RColorBrewer)
}


### testplot
data <- read.csv(paste("data/",inputfile,sep=""), comment.char="#")
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[2:nrow(data),2:ncol(data)])  # transform column 2-5 into a matrix
                                        #rownames(mat_data) <- rnames                  # assign row names

print ("Filtering out unimportant rows")
freqtable <- sort(table(apply(mat_data,1,sum)))
threshold <- as.numeric(names(freqtable)[length(names(freqtable))])
uninportant <- which(apply(mat_data,1,sum)==threshold)

fram3 <- mat_data[-uninportant,]

print (paste("New dataframe consists of", nrow(fram3), " rows."))
print("Drawing heatmap!")
## heatmap(fram3, Rowv=NA, Colv=NA, col = topo.colors(512), scale="column", margins=c(5,10))
print("Heatmaps are generated in the PDF file.")

##                                         # creates a own color palette from red to green
my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 299)

##                                         # (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(1,2,length=100),  # for red
               seq(2.01,3,length=100),        
               seq(3.01,4,length=100))                                                     # creates a 5 x 5 inch image


heatmap.2(fram3,
          cellnote = fram3,  # same data set for cell labels
          main = "Heatmap!", # heat map title
          notecol="black",      # change font color of cell labels to black
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          symkey=F,
          margins =c(12,9),     # widens margins around plot  
          breaks=col_breaks,    # enable color transition at specified limits
          dendrogram="row",     # only draw a row dendrogram
          Colv="NA",col=my_palette)      # use on color palette defined earlier)            # turn off column clustering


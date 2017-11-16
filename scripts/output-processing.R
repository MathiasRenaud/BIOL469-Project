# BIOL469 Final Project -- Processing output files

# Disclaimer: I realize this code is bad! Just trying to get this working as quickly
#             as possible. Contact me if you want to know any details that I've 
#             neglected to annotate.

# Directory containing blast result files
setwd("~/Bioinformatics/pfastGO-results/blast")

# List of blast results
file.list <- list.files(pattern="*.txt")

# Sample names
N <- length(file.list)
names <- c()

for (i in 1:N){
  file.name <- file.list[i]
  long.name <- strsplit(file.name, "\\.")[[1]][1]
  genus.name <- strsplit(long.name, "_")[[1]][1]
  species.name <- strsplit(long.name, "_")[[1]][2]
  name <- paste0(substring(genus.name, 1, 1), "_", species.name)
  names <- c(names, name)
}

# Convert files to dataframes
dflist <- lapply(file.list, function(i){
  table <- read.table(i, header=FALSE, sep="\t", col.names=c("QuerID", "SeqID", "SeqTitle",
                                                             "QuerLen", "SeqLen", "MatchLen",
                                                             "%ID", "nID", "nMismatch",
                                                             "nGaps", "e-val", "bitscore"))
  df <- as.data.frame(table)
  return(df)
  })
names(dflist) <- names

# Remove unwanted data to ease analysis
# ...it seems like there should be a better way to implement this part.
dflist2 <- lapply(dflist, function(x){
  if (nrow(x) == 0){
    
  } else {
    genes <- as.character(x$SeqID)
    info <- as.character(x$SeqTitle)
    
    info.list <- lapply(info, function(i){
      attr.list <- strsplit(i, "\\|")
      gene.name <- sub("name=", "", attr.list[[1]][2])
      sp <- sub("species=", "", attr.list[[1]][3])
      GO <- sub("GO=", "", attr.list[[1]][5])
      kg <- sub("KEGG=", "", attr.list[[1]][7])
      #if (length(kg)==0){
      #  KEGG <- NA
      #} else {
      #  KEGG <- kg
      #}
        
      attrs <- c(gene.name, sp, GO, kg)
      return(attrs)
    })
    
    N <- length(info.list)
    gene.names <- c()
    for (i in 1:N){
      g.n <- info.list[[i]][1]
      gene.names <- c(gene.names, g.n)
    }

    species <- c()
    for (i in 1:N){
      s <- info.list[[i]][2]
      species <- c(species, s)
    }

    GOids <- c()
    for (i in 1:N){
      g <- info.list[[i]][3]
      GOids <- c(GOids, g)
    }
    
    KEGGids <- c()
    for (i in 1:N){
      k <- info.list[[i]][4]
      KEGGids <- c(KEGGids, k)
    }
    
    df2 <- data.frame(genes, gene.names, species, GOids, KEGGids)
    return(df2)
}})
names(dflist2) <- names

# Write modified tables out to TSV files
setwd("gene-tables")
N <- length(dflist2)
for (i in 1:N){
  outfile.name <- names[i]
  write.table(dflist2[i], file=paste0(outfile.name,".tsv"), quote=FALSE, sep='\t',
              row.names=FALSE)
}


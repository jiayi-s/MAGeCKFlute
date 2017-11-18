% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enrich.HGT.R
\docType{methods}
\name{enrich.HGT}
\alias{enrich.HGT}
\alias{Hypergeometric}
\title{Do enrichment analysis using Hypergeometric test}
\usage{
enrich.HGT(gene, universe, type = "KEGG", organism = "hsa",
  pvalueCutoff = 0.05, pAdjustMethod = "BH", minGSSize = 2,
  maxGSSize = 500)
}
\arguments{
\item{gene}{a character vector, specifying the genelist to do enrichment analysis.}

\item{universe}{a character vector, specifying the backgound genelist, default is whole genome.}

\item{type}{geneset category for testing, KEGG(default).}

\item{organism}{a character, specifying organism, such as "hsa" or "Human"(default), and "mmu" or "Mouse"}

\item{pvalueCutoff}{pvalue cutoff.}

\item{pAdjustMethod}{one of "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none".}

\item{minGSSize}{minimal size of each geneSet for testing.}

\item{maxGSSize}{maximal size of each geneSet for analyzing.}
}
\value{
A enrichResult instance.
}
\description{
Do enrichment analysis using Hypergeometric test
}
\note{
See the vignette for an example of enrichment analysis using hypergemetric test
The source can be found by typing \code{MAGeCKFlute:::enrich.HGT}
or \code{getMethod("enrich.HGT")}, or
browsed on github at \url{https://github.com/WubingZhang/MAGeCKFlute/tree/master/R/enrich.HGT.R}
Users should find it easy to customize this function.
}
\examples{
data(MLE_Data)
universe = id2eg(MLE_Data$Gene, "SYMBOL")[,"ENTREZID"]
genes = id2eg(Core_Essential[1:200], "SYMBOL")[,"ENTREZID"]
enrichRes <- enrich.HGT(genes, universe)
head(enrichRes@result)

}
\seealso{
\code{\link{enrich.GOstats}}

\code{\link{enrich.DAVID}}

\code{\link{enrich.GSE}}

\code{\link{enrich.ORT}}

\code{\link{enrichment_analysis}}

\code{\link[DOSE]{enrichResult-class}}
}
\author{
Feizhen Wu
}
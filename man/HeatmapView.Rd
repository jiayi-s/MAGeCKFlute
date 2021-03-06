% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HeatmapView.R
\docType{methods}
\name{HeatmapView}
\alias{HeatmapView}
\title{Draw heatmap}
\usage{
HeatmapView(mat, limit = c(-2, 2),
  colPal = rev(colorRampPalette(c("#c12603", "white", "#0073B6"), space =
  "Lab")(199)), filename = NA, width = NA, height = NA, ...)
}
\arguments{
\item{mat}{Matrix like object, each row is gene and each column is sample.}

\item{limit}{Max value in heatmap}

\item{colPal}{colorRampPalette.}

\item{filename}{File path where to save the picture.}

\item{width}{Manual option for determining the output file width in inches.}

\item{height}{Manual option for determining the output file height in inches.}

\item{...}{Other parameters in pheatmap.}
}
\value{
Invisibly a pheatmap object that is a list with components.
}
\description{
Draw heatmap
}
\examples{
data(mle.gene_summary)
dd = ReadBeta(mle.gene_summary, organism="hsa")
gg = cor(dd[,3:ncol(dd)])
HeatmapView(gg, display_numbers = TRUE)

}
\author{
Wubing Zhang
}

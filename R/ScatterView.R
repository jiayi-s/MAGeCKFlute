#' Scatter plot
#'
#' Scatter plot of all genes, in which x-axis is mean beta score in Control samples, y-axis
#' is mean beta scores in Treatment samples.
#'
#' @docType methods
#' @name ScatterView
#' @rdname ScatterView
#' @aliases scatterview
#'
#' @param beta Data frame, including \code{ctrlname} and \code{treatname} as columns.
#' @param ctrlname A character, specifying the names of control samples.
#' @param treatname A character, specifying the names of treatment samples.
#' @param scale_cutoff Boolean or numeric, whether scale cutoff to whole genome level,
#' or how many standard deviation will be used as cutoff.
#' @param main As in 'plot'.
#' @param filename Figure file name to create on disk. Default filename="NULL", which means
#' don't save the figure on disk.
#' @param width As in ggsave.
#' @param height As in ggsave.
#' @param ... Other available parameters in function 'ggsave'.
#'
#' @return An object created by \code{ggplot}, which can be assigned and further customized.
#'
#' @author Wubing Zhang
#'
#'
#' @seealso \code{\link{SquareView}}
#'
#'
#' @examples
#' data(mle.gene_summary)
#' # Read beta score from gene summary table in MAGeCK MLE results
#' dd = ReadBeta(mle.gene_summary, organism="hsa")
#' ScatterView(dd, ctrlname = "dmso", treatname = "plx")
#'
#'
#' @export
#'

ScatterView <- function(beta, ctrlname="Control",treatname="Treatment", scale_cutoff=2,
                        main=NULL, filename=NULL, width=5, height=4, ...){

  beta$Control=rowMeans(beta[,ctrlname,drop= FALSE])
  beta$Treatment=rowMeans(beta[,treatname,drop= FALSE])
  intercept=CutoffCalling(beta$Treatment-beta$Control, scale=scale_cutoff)
  beta$diff = beta$Treatment - beta$Control
  beta$group="no"
  beta$group[beta$diff>intercept]="up"
  beta$group[beta$diff<(-intercept)]="down"

  data=beta
  message(Sys.time(), " # Scatter plot of ", main, " Treat-Ctrl beta scores ...")
  mycolour=c("no"="aliceblue",  "up"="#e41a1c","down"="#377eb8")
  xmin=min(data$Control)
  xmax=max(data$Control)
  ymin=min(data$Treatment)
  ymax=max(data$Treatment)
  #=========
  p=ggplot(data,aes(x=Control,y=Treatment,colour=group,fill=group))
  p=p+geom_point(position = "identity",shape=".",alpha=1/100,size = 0.01,show.legend = FALSE)
  p=p+scale_color_manual(values=mycolour)
  p=p+geom_jitter(position = "jitter",show.legend = FALSE)
  p = p + theme(text = element_text(colour="black",size = 14, family = "Helvetica"),
                plot.title = element_text(hjust = 0.5, size=18),
                axis.text = element_text(colour="gray10"))
  p = p + theme(axis.line = element_line(size=0.5, colour = "black"),
                panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.border = element_blank(), panel.background = element_blank())
  p=p+geom_abline(intercept = -intercept)
  p=p+geom_abline(intercept = +intercept)
  p=p+labs(x="Control beta score",y="Treatment beta score",title=main)
  p=p+annotate("text",color="#e41a1c",x=xmin, y=ymax,hjust = 0,
               label=paste("GroupA: ",as.character(dim(data[data$group=="up",])[1]),sep=""))
  p=p+annotate("text",color="#377eb8",x=xmax, y=ymin,hjust = 1,
               label=paste("GroupB: ",as.character(dim(data[data$group=="down",])[1]),sep=""))
  #============
  if(!is.null(filename)){
    write.table(beta, file.path(dirname(filename), paste0("GroupAB_", main, ".txt")),
                sep = "\t", quote = FALSE, row.names = FALSE)
    ggsave(plot=p,filename=filename,units = "in", width=width, height =height, ...)
  }
  return(p)
}


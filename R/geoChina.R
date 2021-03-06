##' Download expression dataset by GSE id
##'
##' \code{geoChina} will download the expression matrix and phenotype data as ExpressionSet format from cloud in mainland China,
##' it's a alternative method for getGEO function from GEOquery package.
##' geoChina('gse1009') is the same as eSet=getGEO('gse1009', getGPL = F)
##'
##' @param gse input GSE id, such as GSE1009, GSE2546, default:GSE2546
##' @import GEOquery
##' @return a list of ExpressionSet, which contains the  expression matrix and phenotype data
##' @examples
##' geoChina()
##' geoChina('gse1009')
##' geoChina('GSE1009')
##' @export

geoChina <- function(gse='GSE2546',mirror='tercent'){
  suppressPackageStartupMessages(library(GEOquery))
  options(download.file.method="libcurl")
  # eSet=getGEO('GSE2546', destdir=".", AnnotGPL = F, getGPL = F)
  # http://49.235.27.111/GEOmirror/GSE2nnn/GSE2546_eSet.Rdata
  # gse='GSE2546';mirror='tercent'
  gse=toupper(gse)
  down=ifelse(as.numeric(gsub('GSE','',gse))<1000,
              paste0('/GEOmirror/GSEnnn/',gse,
                     '_eSet.Rdata'),
              paste0('/GEOmirror/',
                     gsub('[0-9][0-9][0-9]$','nnn',gse),'/',gse,
                     '_eSet.Rdata'))

  if(mirror=='tercent'){
    up='http://49.235.27.111'
  }
  tpf=paste0(gse, '_eSet.Rdata')
  download.file(paste0(up,down),tpf,mode = "wb")
  suppressWarnings(load(tpf))
  return(gset)
}

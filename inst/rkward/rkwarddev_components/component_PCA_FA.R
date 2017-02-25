#############
## principal component & factor analysis
#############
# using principal()/fa() of the package 'psych'

# name of the active component, relevant for help page content
rk.set.comp("Factor analysis")

factorMethod <- rk.XML.radio("Factoring method",
  options=list(
    "Principal component analysis"=c(val="PCA"),
    "Exploratory factor analysis"=c(val="EFA", chk=TRUE)
  ),
  id.name="factorMethod"
)
corrMethod <- rk.XML.radio("Correlation method",
  options=list(
    "Pearson product-moment (numeric data)"=c(val="fa", chk=TRUE),
    "Polychoric (polytomous data)"=c(val="fa.poly")
  ),
  id.name="corrMethod"
)
data <- rk.XML.varselector(label="Select data", id.name="data")
dataSelected <- rk.XML.varslot(label="Correlation matrix (or raw data matrix)", source=data, required=TRUE, id.name="dataSelected")

saveResults <- rk.XML.saveobj("Save results to workspace", initial="FA.results", id.name="saveResults")

rotationMethodPCA <- rk.XML.dropdown("Rotation method",
  options=list(
    "none"=c(val="none"),
    "varimax (orthogonal)"=c(val="varimax", chk=TRUE),
    "quatimax (orthogonal)"=c(val="quatimax"),
    "promax"=c(val="promax"),
    "oblimin"=c(val="oblimin"),
    "simplimax"=c(val="simplimax"),
    "cluster"=c(val="cluster")
  ),
  id.name="rotationMethodPCA"
)
rotationMethodEFA <- rk.XML.dropdown("Rotation method",
  options=list(
    "None"=c(val="none"),
    "Varimax (orthogonal)"=c(val="varimax"),
    "Quatimax (orthogonal)"=c(val="quatimax"),
    "BentlerT (orthogonal)"=c(val="bentlerT"),
    "GeominT (orthogonal)"=c(val="geominT"),
    "Bifactor (orthogonal)"=c(val="bifactor"),
    "Promax"=c(val="promax"),
    "Oblimin"=c(val="oblimin", chk=TRUE),
    "Simplimax"=c(val="simplimax"),
    "BentlerQ"=c(val="bentlerQ"),
    "GeominQ"=c(val="geominQ"),
    "Biquartimin"=c(val="biquartimin"),
    "Cluster"=c(val="cluster")
  ),
  id.name="rotationMethodEFA"
)

factorMethodEFA <- rk.XML.dropdown("Factoring method",
  options=list(
    "Minimum residual (ULS)"=c(val="minres", chk=TRUE),
    "Weighted least squares (WLS)"=c(val="wls"),
    "Generalized weighted least squares (GLS)"=c(val="gls"),
    "Principal axis"=c(val="pa"),
    "Maximum likelihood"=c(val="ml")
  ),
  id.name="factorMethodEFA"
)

initCommunalityEst <- rk.XML.radio("Initial communality estimate",
  options=list(
    "Squared multiple correlations"=c(val="true", chk=TRUE),
    "1"=c(val="false")
  ),
  id.name="initCommunalityEst"
)
matrixToFactor <- rk.XML.radio("Matrix to factor",
  options=list(
    "Factor correlation matrix"=c(val="false", chk=TRUE),
    "Factor covariance matrix"=c(val="true")
  ),
  id.name="matrixToFactor"
)
matrixToScore <- rk.XML.radio("Matrix to score",
  options=list(
    "Scores based on structure matrix (oblique)"=c(val="true", chk=TRUE),
    "Scores based on pattern matrix"=c(val="false")
  ),
  id.name="matrixToScore"
)

# common options
numFactors <- rk.XML.spinbox("Number of factors to extract", min=1, initial=1, real=FALSE, id.name="numFactors")
cutoff <- rk.XML.spinbox("Marker item threshold (cut-off)", initial=0.1, id.name="cutoff")
showDecimals <- rk.XML.spinbox("Show decimals", min=0, initial=3, max=20, real=FALSE, id.name="showDecimals")

showResiduals <- rk.XML.cbox("Show residuals", value="true", id.name="showResiduals")
kaiser <- rk.XML.cbox("Apply Kaiser normalization", id.name="kaiser")

factorScoreMethod <- rk.XML.dropdown("Method to find factor scores",
  options=list(
    "Regression"=c(val="regression", chk=TRUE),
    "Simple regression (Thurstone)"=c(val="Thurstone"),
    "correlation preserving (ten Berge)"=c(val="tenBerge"),
    "Anderson"=c(val="Anderson"),
    "Bartlett"=c(val="Bartlett")
  ),
  id.name="factorScoreMethod"
)
missingsPCA <- rk.XML.dropdown("Dealing with missing values",
  options=list(
    "Don't impute missing values"=c(val="none", chk=TRUE),
    "Replace with median"=c(val="median"),
    "Replace with mean"=c(val="mean")
  ),
  id.name="missingsPCA"
)
missingsEFA <- rk.XML.dropdown("Dealing with missing values",
  options=list(
    "Don't impute missing values"=c(val="none", chk=TRUE),
    "Replace with median"=c(val="median"),
    "Replace with mean"=c(val="mean")
  ),
  id.name="missingsEFA"
)
componentScores <- rk.XML.frame(missingsPCA, label="Find component scores", checkable=TRUE, chk=FALSE, id.name="componentScores")
numObs <- rk.XML.spinbox("Number of observations to find the correlation matrix (GoF statistics)",
  min=0,
  initial=0,
  real=FALSE,
  id.name="numObs"
)

numIter <- rk.XML.spinbox("Number of iterations", min=2, initial=2, real=FALSE, id.name="numIter")
minErr <- rk.XML.spinbox("Until change in communalities is less than", min=0.0001, initial=0.001, id.name="minErr")
maxIter <- rk.XML.spinbox("Maximum number of iterations", min=2, initial=50, real=FALSE, id.name="maxIter")
iterate <- rk.XML.frame(
  rk.XML.row(
    rk.XML.col(numIter),
    rk.XML.col(minErr),
    rk.XML.col(maxIter)
  ),
  label="Perform bootstrap iterations",
  checkable=TRUE,
  chk=FALSE,
  id.name="iterate"
)

tab1.data <- rk.XML.row(
    data,
    rk.XML.col(
      rk.XML.frame(dataSelected),
      rk.XML.frame(factorMethod),
      rk.XML.frame(corrMethod),
      numFactors,
      rk.XML.stretch(),
      saveResults
    )
  )

tab2.options <- rk.XML.row(
    rk.XML.col(
      rk.XML.row(
        rk.XML.col(
          rotationMethodPCA,
          rotationMethodEFA
        ),
        rk.XML.col(
          factorMethodEFA
        )
      ),
      rk.XML.row(
        rk.XML.col(initCommunalityEst),
        rk.XML.col(matrixToFactor),
        rk.XML.col(matrixToScore)
      ),
      rk.XML.frame(
        rk.XML.row(
          rk.XML.col(showResiduals),
          rk.XML.col(kaiser)
        )
      ),
      componentScores,
      rk.XML.row(
        rk.XML.col(factorScoreMethod),
        rk.XML.col(missingsEFA)
      ),
       numObs,
      iterate,
       rk.XML.stretch(),
      rk.XML.frame(
        rk.XML.row(
          rk.XML.col(cutoff),
          rk.XML.col(showDecimals)
        ),
      label="Output")
    ), id.name="row_cPCAREFARNmain"
   )

full.dialog <- rk.XML.dialog(rk.XML.tabbook(label="Factor analysis",
    tabs=list("Data"=tab1.data, "Options"=tab2.options)
  ), label="Factor analysis")

## logic section
  lgc.sect <- rk.XML.logic(
    FA.gov.analysis <- rk.XML.convert(sources=list(string=factorMethod), mode=c(equals="PCA")),
    FA.gov.corr <- rk.XML.convert(sources=list(string=corrMethod), mode=c(equals="fa")),
    FA.gov.fa <- rk.XML.convert(sources=list(not=FA.gov.analysis, FA.gov.corr), mode=c(and=""), id.name="lgc_lgcFPCACfa"),
    FA.gov.notpoly <- rk.XML.convert(sources=list(FA.gov.analysis, FA.gov.corr), mode=c(or=""), id.name="lgc_lgcFPCACnp"),
    rk.XML.connect(governor=FA.gov.analysis, client=rotationMethodPCA, set="visible"),
    rk.XML.connect(governor=FA.gov.analysis, client=rotationMethodEFA, set="visible", not=TRUE),
    rk.XML.connect(governor=FA.gov.analysis, client=factorMethodEFA, set="enabled", not=TRUE),
    rk.XML.connect(governor=FA.gov.analysis, client=initCommunalityEst, set="enabled", not=TRUE),
    rk.XML.connect(governor=FA.gov.fa, client=matrixToFactor, set="enabled"),
    rk.XML.connect(governor=FA.gov.notpoly, client=showResiduals, set="enabled"),
    rk.XML.connect(governor=FA.gov.analysis, client=matrixToScore, set="enabled", not=TRUE),
    rk.XML.connect(governor=FA.gov.analysis, client=componentScores, set="visible"),
    rk.XML.connect(governor=FA.gov.analysis, client=factorScoreMethod, set="visible", not=TRUE),
    rk.XML.connect(governor=FA.gov.fa, client=factorScoreMethod, set="enabled"),
    rk.XML.connect(governor=FA.gov.analysis, client=missingsEFA, set="visible", not=TRUE),
    rk.XML.connect(governor=FA.gov.analysis, client=iterate, set="enabled", not=TRUE),
    rk.XML.connect(governor=FA.gov.analysis, client=corrMethod, set="enabled", not=TRUE)
)

## JavaScript
# discard this object later, we just need the name...
js.frm.score <- rk.JS.vars(componentScores, modifiers="checked")
js.frm.iterate <- rk.JS.vars(iterate, modifiers="checked")

js.calc <- rk.paste.JS(
  # create a variable for oblique transformations
  "var obrot = new Array(\"promax\", \"oblimin\", \"simplimax\", \"bentlerQ\", \"geominQ\", \"biquartimin\", \"cluster\");\n",
  js(
    if(id("(obrot.indexOf(",rotationMethodEFA ,") == -1 && ", factorMethod,
    " != \"PCA\") | (obrot.indexOf(", rotationMethodPCA ,") == -1 && ", factorMethod,
    " == \"PCA\")")){
      "isObrot = false;"
    } else {
      "isObrot = true;"
    }
  ),
  echo("\tFA.results <- "),
  js(
    if(factorMethod == "PCA"){
      echo("principal(")
    } else if(kaiser){
      echo("kaiser(", corrMethod, "(")
    } else {
      echo(corrMethod, "(")
    },
    if(dataSelected){ 
      if(factorMethod == "EFA" && corrMethod == "fa.poly"){
        echo("x=", dataSelected)
      } else {
        echo("r=", dataSelected)
      }
    } else {},
    if(numFactors > 1){
      echo(",\n\t\tnfactors=", numFactors)
    } else {},
    if((factorMethod == "PCA" || corrMethod == "fa") && showResiduals){
      echo(",\n\t\tresiduals=TRUE")
    } else {},
    if(factorMethod == "PCA"){
      echo(",\n\t\trotate=\"", rotationMethodPCA, "\"")
    } else {
      if(kaiser){
        echo(",\n\t\trotate=\"none\"")
      } else {
        echo(",\n\t\trotate=\"", rotationMethodEFA, "\"")
      }
    },
    if(numObs > 0){
      echo(",\n\t\tn.obs=", numObs)
    } else {},
    if(factorMethod == "PCA"){
      if(js.frm.score){
        echo(",\n\t\tscores=TRUE")
      } else {}
      if(js.frm.score && missingsPCA != "none"){
        echo(",\n\t\tmissing=TRUE,\n\t\timpute=\"", missingsPCA, "\"")
      } else {}
    } else {
      if(js.frm.iterate){
        echo(",\n\t\tn.iter=", numIter)
      } else {}
      if(corrMethod == "fa"){
        echo(",\n\t\tscores=\"", factorScoreMethod, "\"")
      } else {}
      if(initCommunalityEst == "false"){
        echo(",\n\t\tSMC=FALSE")
      } else {}
      if(corrMethod == "fa" && matrixToFactor == "true"){
        echo(",\n\t\tcovar=TRUE")
      } else {}
      if(missingsEFA != "none"){
        echo(",\n\t\tmissing=TRUE,\n\t\timpute=\"", missingsEFA, "\"")
      } else {}
      if(js.frm.iterate && minErr != 0.001){
        echo(",\n\t\tmin.err=", minErr)
      } else {}
      if(js.frm.iterate && maxIter != 50){
        echo(",\n\t\tmax.iter=", maxIter)
      } else {}
      echo(",\n\t\tfm=\"", factorMethodEFA, "\"")
      if(matrixToScore == "false"){
        echo(",\n\t\toblique.scores=FALSE")
      } else {}
    },
    if(factorMethod == "EFA" && kaiser){
      echo("), rotate=\"", rotationMethodEFA, "\"")
    } else {}
  ),
  echo(")\n\n")
)

js.print <- rk.paste.JS(
  rk.JS.vars(factorMethod, numFactors, rotationMethodPCA, factorMethodEFA, rotationMethodEFA,
    kaiser, showDecimals, cutoff),
  echo("\tdigits <- function(obj) {
    return(format(round(obj, digits=", showDecimals, "), nsmall=", showDecimals, "))
  }\n"),
  R.comment("Make matrix from loadings, for more flexible output"),
  echo("\tFA.load.dim <- dim(FA.results$loadings)
  FA.load.names <- dimnames(FA.results$loadings)\n"),
  R.comment("Nicen component names"),
  echo("\tFA.load.names[[2]] <- paste("),
  js(
    if(factorMethod == "PCA"){
      echo("\"Component\"")
    } else {
      echo("\"Factor\"")
    }
  ),
  echo(", 1:length(FA.load.names[[2]]))
  FA.load <- FA.results$loadings[!is.character(FA.results$loadings)]
  FA.load.mtx <- matrix(FA.load, nrow=FA.load.dim[1], dimnames=FA.load.names)\n"),
  R.comment("For printout, highlight loadings"),
  echo("\tidx.load <- abs(FA.load) >= ", cutoff, "
  FA.load.print <- digits(FA.load)
  FA.load.print[idx.load] <- paste(\"<b>\", FA.load.print[idx.load], \"</b>\", sep=\"\")
  FA.load.print <- matrix(FA.load.print, nrow=FA.load.dim[1], dimnames=FA.load.names)\n"),
  R.comment("Append communality and uniqueness"),
  echo("\tFA.load.print <- cbind(FA.load.print,\n\t\t",
    i18n("communality"), "=paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.results$communality), \"</span>\", sep=\"\"),\n\t\t",
    i18n("uniqueness"), "=paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.results$uniquenesses), \"</span>\", sep=\"\"))\n"),
  R.comment("Append sum of squared loadings"),
  js(
    if("isObrot"){
      echo("\tFA.s2load <- diag(FA.results$Phi %*% t(FA.results$loadings) %*% FA.results$loadings)\n")
    } else {
      echo("\tFA.s2load <- colSums(FA.results$loadings^2)\n")
    }
  ),
  R.comment("Variance explained"),
  echo("\tFA.varExp <- 100 * FA.s2load / FA.load.dim[1]
  FA.load.print <- rbind(FA.load.print,\n\t\t",
    i18n("Sum of squared loadings"), "=c(paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.s2load), \"</span>\", sep=\"\"),
    digits(sum(FA.s2load)), \"\"),\n\t\t",
    i18n("Variance explained (%)"), "=c(paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.varExp), \"</span>\", sep=\"\"), \"\", \"\"),\n\t\t",
    i18n("Variance explained (cum %)"), "=c(paste(\"<span style=\\\"color:grey;\\\">\", digits(cumsum(FA.varExp)), \"</span>\", sep=\"\"), \"\", \"\"))\n"),
  R.comment("Finally, make it a data.frame"),
  echo("\tFA.load.print <- data.frame(FA.load.print, stringsAsFactors=FALSE)\n"),
  js(
    if("isObrot"){
      R.comment("Prepare correlation matrix for printout")
      echo("\tcomp.corr <- digits(FA.results$Phi)
  dimnames(comp.corr) <- list(FA.load.names[[2]],FA.load.names[[2]])\n")
    } else {}
  ),
  R.comment("Prepare score*factors matrix for printout"),
  echo("\tscfc.corr <- data.frame(rbind(\n\t\t",
    i18n("Correlation of scores with factors"), "=digits(sqrt(FA.results$R2)),\n\t\t",
    i18n("Multiple R square of scores with factors"), "=digits(FA.results$R2),\n\t\t",
    i18n("Minimum correlation of possible factor scores"), "=digits((2*FA.results$R2)-1)), stringsAsFactors=FALSE)
  colnames(scfc.corr) <- FA.load.names[[2]]\n\n"),
  R.comment("Ok, here the actual output starts", level=1),
  js(
    if(factorMethod == "PCA"){
      echo("rk.header (", i18n("Principal Component Analysis"))
    } else {
      echo("rk.header (", i18n("Factor Analysis"))
    }
  ),
  echo(",\n\tparameters=list(\n"),
  js(
    if(factorMethod == "PCA"){
      echo(
        "\t\t", i18n("Number of components"), "=", numFactors, ",\n",
        "\t\t", i18n("Rotation"), "=\"", rotationMethodPCA, "\""
      )
    } else {
      echo(
        "\t\t", i18n("Number of factors"), "=", numFactors, ",\n",
        "\t\t", i18n("Factoring method"), "=\"", factorMethodEFA,"\",\n",
        "\t\t", i18n("Rotation"), "=\"", rotationMethodEFA, "\""
      )
      if(kaiser){
        echo(",\n\t\t", i18n("Normalization"), "=\"Kaiser\"")
      } else {}
    }
  ),
  echo("))\n"), # end rk.header()
  echo(
    "rk.results (list(\n\t",
    i18n("Degrees of freedom"), "=FA.results$dof,\n\t",
    i18n("Fit"), "=digits(FA.results$fit),\n\t",
    i18n("Fit (off diag)"), "=digits(FA.results$fit.off)\n\t))\n"
  ),
  rk.JS.header("Loadings", level=4),
  echo("rk.results (FA.load.print)\n"),
  js(
    if("isObrot"){
      rk.JS.header("Factor correlations", level=4)
      echo("rk.results (data.frame(comp.corr, stringsAsFactors=FALSE))\n")
    } else {}
  ),
#  echo("rk.header(\"Test of the hypothesis that ", numFactors, " factors are sufficient\", level=4)\n"),
  rk.JS.header("Measures of factor score adequacy", level=4),
  echo("rk.results (scfc.corr)\n")
)

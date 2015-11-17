// this code was generated using the rkwarddev package.
//perhaps don't make changes here, but in the rkwarddev script instead!

// define variables globally
var isObrot;

function preprocess(){
  // add requirements etc. here
  echo("require(psych)\n");
}

function calculate(){
  // read in variables from dialog
  
  var dataSelected = getString("dataSelected");
  var factorMethod = getString("factorMethod");
  var corrMethod = getString("corrMethod");
  var numFactors = getString("numFactors");
  var saveResults = getString("saveResults");
  var rotationMethodPCA = getString("rotationMethodPCA");
  var rotationMethodEFA = getString("rotationMethodEFA");
  var factorMethodEFA = getString("factorMethodEFA");
  var initCommunalityEst = getString("initCommunalityEst");
  var matrixToFactor = getString("matrixToFactor");
  var matrixToScore = getString("matrixToScore");
  var missingsPCA = getString("missingsPCA");
  var factorScoreMethod = getString("factorScoreMethod");
  var missingsEFA = getString("missingsEFA");
  var numObs = getString("numObs");
  var numIter = getString("numIter");
  var minErr = getString("minErr");
  var maxIter = getString("maxIter");
  var cutoff = getString("cutoff");
  var showDecimals = getString("showDecimals");
  var showResiduals = getBoolean("showResiduals.state");
  var kaiser = getBoolean("kaiser.state");
  var componentScoresChecked = getBoolean("componentScores.checked");
  var iterateChecked = getBoolean("iterate.checked");

  // the R code to be evaluated
  var obrot = new Array("promax", "oblimin", "simplimax", "bentlerQ", "geominQ", "biquartimin", "cluster");

  if((obrot.indexOf(rotationMethodEFA) == -1 && factorMethod != "PCA") | (obrot.indexOf(rotationMethodPCA) == -1 && factorMethod == "PCA")) {
    isObrot = false;  
  } else {
    isObrot = true;  
  }
  echo("\tFA.results <- ");
  if(factorMethod == "PCA") {
    echo("principal(");  
  } else if(kaiser) {
    echo("kaiser(" + corrMethod + "(");  
  } else {
    echo(corrMethod + "(");  
  }
  if(dataSelected) {
    if(factorMethod == "EFA" && corrMethod == "fa.poly") {
      echo("x=" + dataSelected);  
    } else {
      echo("r=" + dataSelected);  
    }  
  } else {}
  if(numFactors > 1) {
    echo(",\n\t\tnfactors=" + numFactors);  
  } else {}
  if((factorMethod == "PCA" || corrMethod == "fa") && showResiduals) {
    echo(",\n\t\tresiduals=TRUE");  
  } else {}
  if(factorMethod == "PCA") {
    echo(",\n\t\trotate=\"" + rotationMethodPCA + "\"");  
  } else {
    if(kaiser) {
      echo(",\n\t\trotate=\"none\"");  
    } else {
      echo(",\n\t\trotate=\"" + rotationMethodEFA + "\"");  
    }  
  }
  if(numObs > 0) {
    echo(",\n\t\tn.obs=" + numObs);  
  } else {}
  if(factorMethod == "PCA") {
    if(componentScoresChecked) {
      echo(",\n\t\tscores=TRUE");  
    } else {}  
    if(componentScoresChecked && missingsPCA != "none") {
      echo(",\n\t\tmissing=TRUE,\n\t\timpute=\"" + missingsPCA + "\"");  
    } else {}  
  } else {
    if(iterateChecked) {
      echo(",\n\t\tn.iter=" + numIter);  
    } else {}  
    if(corrMethod == "fa") {
      echo(",\n\t\tscores=\"" + factorScoreMethod + "\"");  
    } else {}  
    if(initCommunalityEst == "false") {
      echo(",\n\t\tSMC=FALSE");  
    } else {}  
    if(corrMethod == "fa" && matrixToFactor == "true") {
      echo(",\n\t\tcovar=TRUE");  
    } else {}  
    if(missingsEFA != "none") {
      echo(",\n\t\tmissing=TRUE,\n\t\timpute=\"" + missingsEFA + "\"");  
    } else {}  
    if(iterateChecked && minErr != 0.001) {
      echo(",\n\t\tmin.err=" + minErr);  
    } else {}  
    if(iterateChecked && maxIter != 50) {
      echo(",\n\t\tmax.iter=" + maxIter);  
    } else {}  
    echo(",\n\t\tfm=\"" + factorMethodEFA + "\"");  
    if(matrixToScore == "false") {
      echo(",\n\t\toblique.scores=FALSE");  
    } else {}  
  }
  if(factorMethod == "EFA" && kaiser) {
    echo("), rotate=\"" + rotationMethodEFA + "\"");  
  } else {}
  echo(")\n\n");
}

function printout(){
  // printout the results


  var factorMethod = getValue("factorMethod");
  var numFactors = getValue("numFactors");
  var rotationMethodPCA = getValue("rotationMethodPCA");
  var factorMethodEFA = getValue("factorMethodEFA");
  var rotationMethodEFA = getValue("rotationMethodEFA");
  var kaiser = getValue("kaiser");
  var showDecimals = getValue("showDecimals");
  var cutoff = getValue("cutoff");
  echo("\tdigits <- function(obj) {\n    return(format(round(obj, digits=" + showDecimals + "), nsmall=" + showDecimals + "))\n  }\n");
  comment("Make matrix from loadings, for more flexible output", "  ");
  echo("\tFA.load.dim <- dim(FA.results$loadings)\n  FA.load.names <- dimnames(FA.results$loadings)\n");
  comment("Nicen component names", "  ");
  echo("\tFA.load.names[[2]] <- paste(");
  if(factorMethod == "PCA") {
    echo("\"Component\"");  
  } else {
    echo("\"Factor\"");  
  }
  echo(", 1:length(FA.load.names[[2]]))\n  FA.load <- FA.results$loadings[!is.character(FA.results$loadings)]\n  FA.load.mtx <- matrix(FA.load, nrow=FA.load.dim[1], dimnames=FA.load.names)\n");
  comment("For printout, highlight loadings", "  ");
  echo("\tidx.load <- FA.load >= " + cutoff + "\n  FA.load.print <- digits(FA.load)\n  FA.load.print[idx.load] <- paste(\"<b>\", FA.load.print[idx.load], \"</b>\", sep=\"\")\n  FA.load.print <- matrix(FA.load.print, nrow=FA.load.dim[1], dimnames=FA.load.names)\n");
  comment("Append communality and uniqueness", "  ");
  echo("\tFA.load.print <- cbind(FA.load.print,\n    \"communality\"=paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.results$communality), \"</span>\", sep=\"\"),\n    \"uniqueness\"=paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.results$uniquenesses), \"</span>\", sep=\"\"))\n");
  comment("Append sum of squared loadings", "  ");
  if(isObrot) {
    echo("\tFA.s2load <- diag(FA.results$Phi %*% t(FA.results$loadings) %*% FA.results$loadings)\n");  
  } else {
    echo("\tFA.s2load <- colSums(FA.results$loadings^2)\n");  
  }
  comment("Variance explained", "  ");
  echo("\tFA.varExp <- 100 * FA.s2load / FA.load.dim[1]\n  FA.load.print <- rbind(FA.load.print,\n    \"Sum of squared loadings\"=c(paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.s2load), \"</span>\", sep=\"\"),\n    digits(sum(FA.s2load)), \"\"),\n    \"Variance explained (%)\"=c(paste(\"<span style=\\\"color:grey;\\\">\", digits(FA.varExp), \"</span>\", sep=\"\"), \"\", \"\"),\n    \"Variance explained (cum %)\"=c(paste(\"<span style=\\\"color:grey;\\\">\", digits(cumsum(FA.varExp)), \"</span>\", sep=\"\"), \"\", \"\"))\n");
  comment("Finally, make it a data.frame", "  ");
  echo("\tFA.load.print <- data.frame(FA.load.print, stringsAsFactors=FALSE)\n");
  if(isObrot) {
    comment("Prepare correlation matrix for printout", "  ");  
    echo("\tcomp.corr <- digits(FA.results$Phi)\n  dimnames(comp.corr) <- list(FA.load.names[[2]],FA.load.names[[2]])\n");  
  } else {}
  comment("Prepare score*factors matrix for printout", "  ");
  echo("\tscfc.corr <- data.frame(rbind(\n    \"Correlation of scores with factors\"=digits(sqrt(FA.results$R2)),\n    \"Multiple R square of scores with factors\"=digits(FA.results$R2),\n    \"Minimum correlation of possible factor scores\"=digits((2*FA.results$R2)-1)), stringsAsFactors=FALSE)\n  colnames(scfc.corr) <- FA.load.names[[2]]\n\n");
  comment("Ok, here the actual output starts");
  if(factorMethod == "PCA") {
    echo("rk.header(\"Principal Component Analysis\"");  
  } else {
    echo("rk.header(\"Factor Analysis\"");  
  }
  echo(",\n\tparameters=list(");
  if(factorMethod == "PCA") {
    echo("\t\t\"Number of components\", " + numFactors + ",\n" + "\t\t\"Rotation\", \"" + rotationMethodPCA + "\"");  
  } else {
    echo("\t\t\"Number of factors\", " + numFactors + ",\n" + "\t\t\"Factoring method\", \"" + factorMethodEFA + "\",\n" + "\t\t\"Rotation\", \"" + rotationMethodEFA + "\"");  
    if(kaiser) {
      echo(",\n\t\t\"Normalization\", \"Kaiser\"");  
    } else {}  
  }
  echo("))\n");
  echo("rk.results(list(\n  \"Degrees of freedom\"=FA.results$dof,\n  \"Fit\"=digits(FA.results$fit),\n  \"Fit (off diag)\"=digits(FA.results$fit.off)\n  ))\n");
  echo("rk.header(\"Loadings\", level=4)\n");
  echo("rk.results(FA.load.print)\n");
  if(isObrot) {
    echo("rk.header(\"Factor correlations\", level=4)\nrk.results(data.frame(comp.corr, stringsAsFactors=FALSE))\n");  
  } else {}
  echo("rk.header(\"Measures of factor score adequacy\", level=4)\n");
  echo("rk.results(scfc.corr)\n");
  //// save result object
  // read in saveobject variables
  var saveResults = getValue("saveResults");
  var saveResultsActive = getValue("saveResults.active");
  var saveResultsParent = getValue("saveResults.parent");
  // assign object to chosen environment
  if(saveResultsActive) {
    echo(".GlobalEnv$" + saveResults + " <- FA.results\n");
  } else {}

}


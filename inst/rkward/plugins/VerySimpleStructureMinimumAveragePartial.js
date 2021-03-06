// this code was generated using the rkwarddev package.
// perhaps don't make changes here, but in the rkwarddev script instead!

function preview(){
  preprocess(true);
  calculate(true);
  printout(true);
}

function preprocess(is_preview){
  // add requirements etc. here
  if(is_preview) {
    echo("if(!base::require(psych)){stop(" + i18n("Preview not available, because package psych is not installed or cannot be loaded.") + ")}\n");
  } else {
    echo("require(psych)\n");
  }
}

function calculate(is_preview){
  // read in variables from dialog
  var vssDataSelected = getString("vssDataSelected");
  var vssFactorMethod = getString("vssFactorMethod");
  var vssNumObs = getString("vssNumObs");
  var vssRotate = getString("vssRotate");
  var vssMainTitle = getString("vssMainTitle");
  var fitDiag = getBoolean("fitDiag.state");
  var connectDiffCplx = getBoolean("connectDiffCplx.state");
  var vssPlotResultsChecked = getBoolean("vssPlotResults.checked");

  // the R code to be evaluated
  echo("\t\tVSS.data <- VSS(");
  if(vssDataSelected) {
    echo("\n\t\t\t" + vssDataSelected);  
  } else {}
  if(vssFactorMethod == "ml" && vssNumObs != 0) {
    echo(",\n\t\t\tn.obs=" + vssNumObs);  
  } else {}
  if(vssFactorMethod != "minres") {
    echo(",\n\t\t\tfm=\"" + vssFactorMethod + "\"");  
  } else {}
  if(vssRotate != "varimax") {
    echo(",\n\t\t\trotate=\"" + vssRotate + "\"");  
  } else {}
  if(fitDiag) {
    echo(",\n      diagonal=TRUE");
  } else {}
  echo(",\n\t\t\tplot=FALSE)\n");
  echo("\n\t\tvss.stat.vars <- c(\"dof\",\"chisq\",\"prob\",\"sqresid\",\"fit\",\"cfit.1\",\"cfit.2\")\n" + "\n\t\tvss.stat.results <- as.data.frame(cbind(Factors=1:length(VSS.data[[\"map\"]]), MAP=VSS.data[[\"map\"]], VSS.data[[\"vss.stats\"]][,vss.stat.vars]))\n" + "\t\tcolnames(vss.stat.results)[3:9] <- paste(\"VSS\", vss.stat.vars, sep=\".\")\n\n" + "\t\tmin.MAP <- which.min(VSS.data[[\"map\"]])\n" + "\t\tmin.VSS1 <- which.min(VSS.data[[\"cfit.1\"]])\n" + "\t\tmin.VSS2 <- which.min(VSS.data[[\"cfit.2\"]])\n\n");
}

function printout(is_preview){
  // read in variables from dialog
  var vssDataSelected = getString("vssDataSelected");
  var vssFactorMethod = getString("vssFactorMethod");
  var vssNumObs = getString("vssNumObs");
  var vssRotate = getString("vssRotate");
  var vssMainTitle = getString("vssMainTitle");
  var fitDiag = getBoolean("fitDiag.state");
  var connectDiffCplx = getBoolean("connectDiffCplx.state");
  var vssPlotResultsChecked = getBoolean("vssPlotResults.checked");

  // printout the results
  if(!is_preview) {
    new Header(i18n("Very Simple Structure/Minimum Average Partial results")).print();  
  } else {}  var vssPlotResultsChecked = getValue("vssPlotResults.checked");
  if(vssPlotResultsChecked) {
    

  if(!is_preview) {
    echo("rk.graph.on()\n");  
  } else {}
  echo("  try({\n");

  

  // the actual plot:
  echo("\t\tVSS.plot(VSS.data");
  if(vssMainTitle != "Very Simple Structure") {
    echo(",\n\t\t\ttitle=\"" + vssMainTitle + "\"");  
  } else {}
  if(connectDiffCplx) {
    echo(",\n\t\t\tline=TRUE");  
  } else {}
  echo(")\n");

  

  echo("\n  })\n");
  if(!is_preview) {
    echo("rk.graph.off()\n");  
  } else {}  
  } else {}
  new Header(i18n("Very Simple Structure"), 4).print();
  echo("rk.print(paste(" + i18n("VSS complexity 1 achieves a maximimum of ") + ", round(VSS.data[[\"cfit.1\"]][min.VSS1], digits=3), " + i18n(" with ") + ", min.VSS1, " + i18n(" factors.") + ", sep=\"\"))\n" + "rk.print(paste(" + i18n("VSS complexity 2 achieves a maximimum of ") + ", round(VSS.data[[\"cfit.2\"]][min.VSS2], digits=3), " + i18n(" with ") + ", min.VSS2, " + i18n(" factors.") + ", sep=\"\"))\n\n");
  new Header(i18n("Minimum Average Partial"), 4).print();
  echo("rk.print(paste(" + i18n("The Velicer MAP criterion achieves a minimum of ") + ", round(VSS.data[[\"map\"]][min.MAP], digits=3), " + i18n(" with ") + ", min.MAP, " + i18n(" factors.") + ", sep=\"\"))\n\n");
  new Header(i18n("Statistics"), 4).print();
  echo("rk.results(vss.stat.results)\n\n");
  if(!is_preview) {
    //// save result object
    // read in saveobject variables
    var vssSaveResults = getValue("vssSaveResults");
    var vssSaveResultsActive = getValue("vssSaveResults.active");
    var vssSaveResultsParent = getValue("vssSaveResults.parent");
    // assign object to chosen environment
    if(vssSaveResultsActive) {
      echo(".GlobalEnv$" + vssSaveResults + " <- VSS.data\n");
    } else {}  
  } else {}

}


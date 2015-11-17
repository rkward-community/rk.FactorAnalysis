// this code was generated using the rkwarddev package.
//perhaps don't make changes here, but in the rkwarddev script instead!



function preprocess(){
  // add requirements etc. here
  echo("require(psych)\n");
}

function calculate(){
}

function printout(){
  // all the real work is moved to a custom defined function doPrintout() below
  // true in this case means: We want all the headers that should be printed in the output:
  doPrintout(true);
}

function preview(){
  preprocess();
  calculate();
  doPrintout(false);
}

function doPrintout(full){
  // read in variables from dialog
  var hornDataSelected = getString("hornDataSelected");
  var hornMainTitle = getString("hornMainTitle");
  var eigenvalueType = getString("eigenvalueType");
  var hornFactorMethod = getString("hornFactorMethod");
  var hornNumObs = getString("hornNumObs");
  var hornNumIter = getString("hornNumIter");
  var hornSaveResults = getString("hornSaveResults");
  var SMCs = getBoolean("SMCs.state");
  var errorBars = getBoolean("errorBars.state");
  var showLegend = getBoolean("showLegend.state");

  // create the plot
  if(full) {
    new Header(i18n("Parallel analysis (Horn) results")).print();
  } else {}

  

  if(full) {
    echo("rk.graph.on()\n");
  } else {}
  echo("  try({\n");

  

  // the actual plot:
  echo("\t\tparallel.data <- fa.parallel(");
  if(hornDataSelected) {
    echo("\n\t\t\t" + hornDataSelected);  
  } else {}
  if(hornNumObs != 0) {
    echo(",\n\t\t\tn.obs=" + hornNumObs);  
  } else {}
  if(hornFactorMethod != "minres") {
    echo(",\n\t\t\tfm=\"" + hornFactorMethod + "\"");  
  } else {}
  if(eigenvalueType != "both") {
    echo(",\n\t\t\tfa=\"" + eigenvalueType + "\"");  
  } else {}
  if(hornMainTitle != "Parallel Analysis Scree Plots") {
    echo(",\n\t\t\tmain=\"" + hornMainTitle + "\"");  
  } else {}
  if(hornNumIter != 20) {
    echo(",\n\t\t\tn.iter=" + hornNumIter);  
  } else {}
  if(errorBars) {
    echo(",\n      error.bars=TRUE");
  } else {}
  if(SMCs) {
    echo(",\n      SMC=TRUE");
  } else {}
  if(!showLegend) {
    echo(",\n      show.legend=FALSE");
  } else {}
  echo(")");

  

  echo("\n  })\n");
  if(full) {
    echo("rk.graph.off()\n");
  } else {}

  // left over from the printout function

  //// save result object
  // read in saveobject variables
  var hornSaveResults = getValue("hornSaveResults");
  var hornSaveResultsActive = getValue("hornSaveResults.active");
  var hornSaveResultsParent = getValue("hornSaveResults.parent");
  // assign object to chosen environment
  if(hornSaveResultsActive) {
    echo(".GlobalEnv$" + hornSaveResults + " <- parallel.data\n");
  } else {}


}
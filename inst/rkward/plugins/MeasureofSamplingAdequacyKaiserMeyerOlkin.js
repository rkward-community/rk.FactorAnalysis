// this code was generated using the rkwarddev package.
// perhaps don't make changes here, but in the rkwarddev script instead!



function preprocess(is_preview){
  // add requirements etc. here
  echo("require(psych)\n");
}

function calculate(is_preview){
  // read in variables from dialog
  var KMODataSelected = getString("KMODataSelected");
  var KMOshowDecimals = getString("KMOshowDecimals");

  // the R code to be evaluated
  echo("KMO.results <- KMO(");
  if(KMODataSelected) {
    echo(KMODataSelected);  
  } else {}
  echo(")\n\n");
}

function printout(is_preview){
  // printout the results
  var KMOshowDecimals = getValue("KMOshowDecimals");
  comment("Function to round values");
  echo("digits <- function(obj) {\n\treturn(format(round(obj, digits=" + KMOshowDecimals + "), nsmall=" + KMOshowDecimals + "))\n}\n\n");
  comment("Function to add some hints regarding interpretation");
  echo("adequacy <- function(x) {\n" + "\tcol <- \"Red;\\\">" + i18n(noquote("unacceptable")) + "\"\n" + "\tif(x >= .9){\n\t\tcol <- \"DarkGreen;\\\">" + i18n(noquote("marvelous")) + "\"\n\t} else " + "if(x >= .8){\n\t\tcol <- \"ForestGreen;\\\">" + i18n(noquote("mertitourious")) + "\"\n\t} else " + "if(x >= .7){\n\t\tcol <- \"YellowGreen;\\\">" + i18n(noquote("middling")) + "\"\n\t} else " + "if(x >= .6){\n\t\tcol <- \"Gold;\\\">" + i18n(noquote("medicore")) + "\"\n\t} else " + "if(x >= .5){\n\t\tcol <- \"Orange;\\\">" + i18n(noquote("miserable")) + "\"\n\t} else {}\n" + "\treturn(paste0(\"<span style=\\\"color:\", col, \"</span>\"))\n}\n\n");
  comment("Nice format for output");
  echo("MSA.print.results <- data.frame(\n" + "\tMSA=digits(KMO.results[[\"MSA\"]]),\n" + "\tAdequacy=adequacy(KMO.results[[\"MSA\"]]),\n" + "\tstringsAsFactors=FALSE\n" + ")\n");
  echo("MSAi.print.results <- data.frame(\n" + "\tItem=names(KMO.results[[\"MSAi\"]]),\n" + "\tMSAi=digits(KMO.results[[\"MSAi\"]]),\n" + "\tAdequacy=sapply(KMO.results[[\"MSAi\"]], adequacy),\n" + "\tstringsAsFactors=FALSE\n" + ")\n");
  echo("rownames(MSAi.print.results) <- NULL\n\n");
  new Header(i18n("Kaiser-Meyer-Olkin Factor Adequacy")).add(i18n("Data"), noquote("KMO.results[[\"Call\"]][[2]]")).print();
  echo("\n");
  new Header(i18n("Overall Measure of Sampling Adequacy"), 4).print();
  echo("rk.print(MSA.print.results)\n\n");
  new Header(i18n("Measure of Sampling Adequacy per Item"), 4).print();
  echo("rk.print(MSAi.print.results)\n");
  //// save result object
  // read in saveobject variables
  var KMOSaveResults = getValue("KMOSaveResults");
  var KMOSaveResultsActive = getValue("KMOSaveResults.active");
  var KMOSaveResultsParent = getValue("KMOSaveResults.parent");
  // assign object to chosen environment
  if(KMOSaveResultsActive) {
    echo(".GlobalEnv$" + KMOSaveResults + " <- KMO.results\n");
  } else {}

}


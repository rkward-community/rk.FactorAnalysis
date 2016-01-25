// this code was generated using the rkwarddev package.
// perhaps don't make changes here, but in the rkwarddev script instead!



function preview(){
  preprocess(true);
  calculate(true);
  printout(true);
}

function preprocess(is_preview){
  // add requirements etc. here
  echo("require(psych)\n");
}

function calculate(is_preview){
}

function printout(is_preview){
  // read in variables from dialog
  var screeDataSelected = getString("screeDataSelected");
  var mainTitle = getString("mainTitle");
  var screeType = getString("screeType");
  var eigenvalue = getString("eigenvalue");
  var horizLineChecked = getBoolean("horizLine.checked");

  // printout the results
  if(!is_preview) {
    new Header(i18n("Scree plot results")).print();  
  } else {}

  var horizLineChecked = getValue("horizLine.checked");
  

  if(!is_preview) {
    echo("rk.graph.on()\n");  
  } else {}
  echo("  try({\n");

  

  // the actual plot:
  echo("\t\tscree(");
  if(screeDataSelected) {
    echo("\n\t\t\t" + screeDataSelected);  
  } else {}
  if(screeType == "comp") {
    echo(",\n\t\t\tfactors=FALSE");  
  } else {}
  if(screeType == "fact") {
    echo(",\n\t\t\tpc=FALSE");  
  } else {}
  if(mainTitle != "Scree plot") {
    echo(",\n\t\t\tmain=\"" + mainTitle + "\"");  
  } else {}
  if(horizLineChecked) {
    if(eigenvalue != 1) {
      echo(",\n\t\t\thline=" + eigenvalue);  
    } else {}  
  } else {
    echo(",\n\t\t\thline=-1");  
  }
  echo(")");

  

  echo("\n  })\n");
  if(!is_preview) {
    echo("rk.graph.off()\n");  
  } else {}

}


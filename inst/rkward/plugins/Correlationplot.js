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
  var crpltDataSelected = getString("crpltDataSelected");
  var colors = getString("colors");
  var spinLower = getString("spinLower");
  var spinUpper = getString("spinUpper");
  var numShades = getString("numShades");
  var crpltMainTitle = getString("crpltMainTitle");
  var numCat = getString("numCat");
  var crpltShowLegendChecked = getBoolean("crpltShowLegend.checked");

  // create the plot
  if(full) {
    new Header(i18n("Correlation plot")).print();
  } else {}

  var crpltShowLegendChecked = getValue("crpltShowLegend.checked");
  

  if(full) {
    echo("rk.graph.on()\n");
  } else {}
  echo("  try({\n");

  

  // the actual plot:
  echo("\t\tcor.plot(");
  if(crpltDataSelected) {
    echo("\n\t\t\tr=" + crpltDataSelected);  
  } else {}
  if(colors == "false") {
    echo(",\n\t\t\tcolors=FALSE");  
  } else {}
  if(numShades != 51) {
    echo(",\n\t\t\tn=" + numShades);  
  } else {}
  if(crpltMainTitle != "Correlation plot") {
    echo(",\n\t\t\tmain=\"" + crpltMainTitle + "\"");  
  } else {}
  if(spinLower != -1 || spinUpper != 1) {
    echo(",\n\t\t\tzlim=c(" + spinLower + "," + spinUpper + ")");  
  } else {}
  if(crpltShowLegendChecked) {
    if(numCat != 10) {
      echo(",\n\t\t\tn.legend=" + numCat);  
    } else {}  
  } else {
    echo(",\n\t\t\tshow.legend=FALSE");  
  }
  echo("\n\t\t)");

  

  echo("\n  })\n");
  if(full) {
    echo("rk.graph.off()\n");
  } else {}
}
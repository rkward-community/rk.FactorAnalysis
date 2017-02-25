############
## Horn's parallel analysis
############
# name of the active component, relevant for help page content
rk.set.comp("Parallel analysis (Horn)")

hornData <- rk.XML.varselector(label="Select data.frame/matrix", id.name="hornData")
hornDataSelected <- rk.XML.varslot(label="Data", source=hornData, required=TRUE, id.name="hornDataSelected")

# minres, ml, uls, wls, gls, pa
hornFactorMethod <- rk.XML.dropdown("Factoring method",
  options=list(
    "Minimum residual (ULS)"=c(val="minres", chk=TRUE),
    "Weighted least squares (WLS)"=c(val="wls"),
    "Generalized weighted least squares (GLS)"=c(val="gls"),
    "Principal axis"=c(val="pa"),
    "Maximum likelihood"=c(val="ml")
  ),
  id.name="hornFactorMethod"
)


eigenvalueType <- rk.XML.radio(label="Show Eigenvalues for",
  options=list(
    "Factors and components"=c(val="both"),
    "Factors only"=c(val="fa"),
    "Prinicipal components only"=c(val="pc")
  ),
  id.name="eigenvalueType"
)

hornMainTitle <- rk.XML.input(label="Main title", initial="Parallel Analysis Scree Plots", id.name="hornMainTitle")
# prll.ylabel <- rk.XML.input(label="Y axis", initial="Eigen values of factors and components")

hornNumObs <- rk.XML.spinbox("Number of observations (0 implies raw data)", min=0, initial=0, real=FALSE, id.name="hornNumObs")

hornNumIter <- rk.XML.spinbox("Number of iterations", min=2, initial=20, real=FALSE, id.name="hornNumIter")

SMCs <- rk.XML.cbox("Estimate communalities by SMCs", id.name="SMCs")

errorBars <- rk.XML.cbox("Plot error bars", id.name="errorBars")

showLegend <- rk.XML.cbox("Show legend", chk=TRUE, id.name="showLegend")

prll.preview <- rk.XML.preview()

hornSaveResults <- rk.XML.saveobj("Save data to workspace", initial="parallel.data", id.name="hornSaveResults")


prll.full.dialog <- rk.XML.dialog(
  rk.XML.row(
    hornData,
    rk.XML.col(
      hornDataSelected,
      hornMainTitle,
      eigenvalueType,
      hornFactorMethod,
      hornNumObs,
      hornNumIter,
      SMCs,
      errorBars,
      showLegend,
      rk.XML.stretch(),
      hornSaveResults,
      prll.preview
    )
  )
, label="Parallel analysis")

## JavaScript
prll.js.print <- rk.paste.JS.graph(
  echo("\t\tparallel.data <- fa.parallel("),
  js(
    if(hornDataSelected){
      echo("\n\t\t\t", hornDataSelected)
    } else {},
    if(hornNumObs != 0){
      echo(",\n\t\t\tn.obs=", hornNumObs) # NULL
    } else {},
    if(hornFactorMethod != "minres"){
      echo(",\n\t\t\tfm=\"", hornFactorMethod, "\"")
    } else {},
    if(eigenvalueType != "both"){
      echo(",\n\t\t\tfa=\"", eigenvalueType, "\"")
    } else {},
    if(hornMainTitle != "Parallel Analysis Scree Plots"){
      echo(",\n\t\t\tmain=\"", hornMainTitle, "\"")
    } else {},
    if(hornNumIter != 20){
      echo(",\n\t\t\tn.iter=", hornNumIter)
    } else {}
  ),
  tf(errorBars, opt="error.bars", level=4), # FALSE
  tf(SMCs, opt="SMC", level=4), # FALSE
  # prll.ylabel # NULL
  tf(showLegend, opt="show.legend", true=FALSE, not=TRUE, level=4), # TRUE
  echo(")")
)

## make a whole component
prll.component <- rk.plugin.component("Parallel analysis (Horn)",
  xml=list(
    dialog=prll.full.dialog),
  js=list(
    require="psych",
    printout=prll.js.print),
  guess.getter=guess.getter,
  hierarchy=list("analysis", "Factor analysis","Number of factors"),
  create=c("xml", "js"))

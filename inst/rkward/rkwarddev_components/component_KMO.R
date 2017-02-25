############
## Measure of Sampling Adequacy (Kaiser-Meyer-Olkin)
############
# name of the active component, relevant for help page content
rk.set.comp("Measure of Sampling Adequacy (Kaiser-Meyer-Olkin)")

KMOData <- rk.XML.varselector(label="Select data", id.name="KMOData")
KMODataSelected <- rk.XML.varslot(label="Correlation matrix (or raw data matrix)", source=KMOData, required=TRUE, id.name="KMODataSelected")

KMOshowDecimals <- rk.XML.spinbox("Show decimals", min=0, initial=3, max=20, real=FALSE, id.name="KMOshowDecimals")

KMOSaveResults <- rk.XML.saveobj("Save results to workspace", initial="KMO.results", id.name="KMOSaveResults")

KMO.full.dialog <- rk.XML.dialog(
  rk.XML.row(
    KMOData,
    rk.XML.col(
      KMODataSelected,
      rk.XML.stretch(),
      KMOshowDecimals,
      KMOSaveResults
    )
  ),
  label="Measure of Sampling Adequacy (Kaiser-Meyer-Olkin)"
)

## JavaScript
KMO.js.calc <- rk.paste.JS(
  echo("KMO.results <- KMO("),
  js(
    if(KMODataSelected){
      echo(KMODataSelected)
    } else {}
  ),
  echo(")\n\n")
)

KMO.js.print <- rk.paste.JS(
  rk.JS.vars(KMOshowDecimals),
  R.comment("Function to round values", level=1),
  echo("digits <- function(obj) {\n\treturn(format(round(obj, digits=", KMOshowDecimals, "), nsmall=", KMOshowDecimals, "))\n}\n\n"),
  R.comment("Function to add some hints regarding interpretation", level=1),
  echo("adequacy <- function(x) {\n",
    "\tcol <- \"Red;\\\">", i18n(noquote("unacceptable")), "\"\n",
    "\tif(x >= .9){\n\t\tcol <- \"DarkGreen;\\\">", i18n(noquote("marvelous")), "\"\n\t} else ",
    "if(x >= .8){\n\t\tcol <- \"ForestGreen;\\\">", i18n(noquote("mertitourious")), "\"\n\t} else ",
    "if(x >= .7){\n\t\tcol <- \"YellowGreen;\\\">", i18n(noquote("middling")), "\"\n\t} else ",
    "if(x >= .6){\n\t\tcol <- \"Gold;\\\">", i18n(noquote("medicore")), "\"\n\t} else ",
    "if(x >= .5){\n\t\tcol <- \"Orange;\\\">", i18n(noquote("miserable")), "\"\n\t} else {}\n",
    "\treturn(paste0(\"<span style=\\\"color:\", col, \"</span>\"))\n}\n\n"
  ),
  R.comment("Nice format for output", level=1),
  echo("MSA.print.results <- data.frame(\n",
      "\tMSA=digits(KMO.results[[\"MSA\"]]),\n",
      "\tAdequacy=adequacy(KMO.results[[\"MSA\"]]),\n",
      "\tstringsAsFactors=FALSE\n",
    ")\n"
  ),
  echo("MSAi.print.results <- data.frame(\n",
      "\tItem=names(KMO.results[[\"MSAi\"]]),\n",
      "\tMSAi=digits(KMO.results[[\"MSAi\"]]),\n",
      "\tAdequacy=sapply(KMO.results[[\"MSAi\"]], adequacy),\n",
      "\tstringsAsFactors=FALSE\n",
    ")\n"
  ),
  echo("rownames(MSAi.print.results) <- NULL\n\n"),
  rk.JS.header(
    "Kaiser-Meyer-Olkin Factor Adequacy",
    add=c("Data", noquote="KMO.results[[\\\"Call\\\"]][[2]]")
  ),
  echo("\n"),
  rk.JS.header("Overall Measure of Sampling Adequacy", level=4),
  echo("rk.print(MSA.print.results)\n\n"),
  rk.JS.header("Measure of Sampling Adequacy per Item", level=4),
  echo("rk.print(MSAi.print.results)\n")
)

## make a whole component
KMO.component <- rk.plugin.component("Measure of Sampling Adequacy (Kaiser-Meyer-Olkin)",
  xml=list(
    dialog=KMO.full.dialog),
  js=list(
    results.header=FALSE,
    require="psych",
    calculate=KMO.js.calc,
    printout=KMO.js.print
  ),
  guess.getter=guess.getter,
  hierarchy=list("analysis", "Factor analysis"),
  create=c("xml", "js")
)

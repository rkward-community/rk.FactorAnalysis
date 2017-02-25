############
## VSS & MAP
############
# vss(x, n = 8, rotate = "varimax", diagonal = FALSE, fm = "minres", n.obs=NULL,plot=TRUE,title="Very Simple Structure",...)

# name of the active component, relevant for help page content
rk.set.comp("Very Simple Structure/Minimum Average Partial")

vssData <- rk.XML.varselector(label="Select data.frame/matrix", id.name="vssData")
vssDataSelected <- rk.XML.varslot(label="Data", source=vssData, required=TRUE, id.name="vssDataSelected")

# minres, ml, uls, wls, gls, pa
vssFactorMethod <- rk.XML.dropdown("Factoring method",
  options=list(
    "Minimum residual factoring (ULS)"=c(val="minres", chk=TRUE),
    "Principal component analysis"=c(val="pc"),
    "Principal axis factor analysis"=c(val="pa"),
    "Maximum likelihood factor analysis"=c(val="ml")
  ),
  id.name="vssFactorMethod"
)

vssRotate <- rk.XML.dropdown("Rotation method",
  options=list(
    "None"=c(val="none"),
    "Varimax (orthogonal)"=c(val="varimax", chk=TRUE),
    "Promax"=c(val="promax"),
    "Oblimin"=c(val="oblimin")
  ),
  id.name="vssRotate"
)

vssNumFactors <- rk.XML.spinbox("Number of factors to extract", min=1, initial=8, real=FALSE, id.name="vssNumFactors")

vssMainTitle <- rk.XML.input(label="Main title", initial="Very Simple Structure", id.name="vssMainTitle")

vssNumObs <- rk.XML.spinbox("Number of observations", min=0, initial=1000, real=FALSE, id.name="vssNumObs")

fitDiag <- rk.XML.cbox("Fit the diagonal as well", id.name="fitDiag")

# plot options
connectDiffCplx <- rk.XML.cbox("Connect different complexities", id.name="connectDiffCplx")
vss.preview <- rk.XML.preview()
vssPlotResults <- rk.XML.frame(
  vssMainTitle,
  connectDiffCplx,
  vss.preview,
  label="Plot results",
  checkable=TRUE,
  id.name="vssPlotResults"
)

vssSaveResults <- rk.XML.saveobj("Save data to workspace", initial="VSS.data", id.name="vssSaveResults")

vss.full.dialog <- rk.XML.dialog(
  rk.XML.row(
    vssData,
    rk.XML.col(
      vssDataSelected,
      vssFactorMethod,
      vssNumObs,
      vssRotate,
      fitDiag,
      rk.XML.stretch(),
      vssPlotResults,
      vssSaveResults
    )
  )
, label="VSS/MAP")

## logic section
  vss.lgc.sect <- rk.XML.logic(
    vss.gov.factmeth <- rk.XML.convert(sources=list(string=vssFactorMethod), mode=c(equals="ml")),
    rk.XML.connect(governor=vss.gov.factmeth, client=vssNumObs, set="enabled")
  )

## JavaScript
vss.js.calc <- rk.paste.JS(
  echo("\t\tVSS.data <- VSS("),
  js(
    if(vssDataSelected){
      echo("\n\t\t\t", vssDataSelected)
    } else {},
    if(vssFactorMethod == "ml" && vssNumObs != 0){
      echo(",\n\t\t\tn.obs=", vssNumObs) # NULL
    } else {},
    if(vssFactorMethod != "minres"){
      echo(",\n\t\t\tfm=\"", vssFactorMethod, "\"")
    } else {},
    if(vssRotate != "varimax"){
      echo(",\n\t\t\trotate=\"", vssRotate, "\"")
    } else {}
  ),
  tf(fitDiag, opt="diagonal", level=4), # FALSE
  echo(",\n\t\t\tplot=FALSE)\n"),
  echo("\n\t\tvss.stat.vars <- c(\"dof\",\"chisq\",\"prob\",\"sqresid\",\"fit\",\"cfit.1\",\"cfit.2\")\n",
  "\n\t\tvss.stat.results <- as.data.frame(cbind(Factors=1:length(VSS.data[[\"map\"]]), MAP=VSS.data[[\"map\"]], VSS.data[[\"vss.stats\"]][,vss.stat.vars]))\n",
  "\t\tcolnames(vss.stat.results)[3:9] <- paste(\"VSS\", vss.stat.vars, sep=\".\")\n\n",
  "\t\tmin.MAP <- which.min(VSS.data[[\"map\"]])\n",
  "\t\tmin.VSS1 <- which.min(VSS.data[[\"cfit.1\"]])\n",
  "\t\tmin.VSS2 <- which.min(VSS.data[[\"cfit.2\"]])\n\n")
)

vss.js.print <- rk.paste.JS(
  vss.js.frame.plot <- rk.JS.vars(vssPlotResults, modifiers="checked"),
#    echo("rk.print(VSS.data[[\"call\"]])\n"),
  js(
    if(vss.js.frame.plot){
      rk.paste.JS.graph(
        echo("\t\tVSS.plot(VSS.data"),
        js(
          if(vssMainTitle != "Very Simple Structure"){
            echo(",\n\t\t\ttitle=\"", vssMainTitle, "\"")
          } else {},
          if(connectDiffCplx){
            echo(",\n\t\t\tline=TRUE")
          } else {}
        ),
        echo(")\n")
      )
    } else {}
  ),
  rk.JS.header("Very Simple Structure", level=4),
  echo(
    "rk.print(paste(", i18n("VSS complexity 1 achieves a maximimum of "), ", round(VSS.data[[\"cfit.1\"]][min.VSS1], digits=3), ", i18n(" with "), ", min.VSS1, ", i18n(" factors."), ", sep=\"\"))\n",
    "rk.print(paste(", i18n("VSS complexity 2 achieves a maximimum of "), ", round(VSS.data[[\"cfit.2\"]][min.VSS2], digits=3), ", i18n(" with "), ", min.VSS2, ", i18n(" factors."), ", sep=\"\"))\n\n"
  ),
  rk.JS.header("Minimum Average Partial", level=4),
  echo(
    "rk.print(paste(", i18n("The Velicer MAP criterion achieves a minimum of "), ", round(VSS.data[[\"map\"]][min.MAP], digits=3), ", i18n(" with "), ", min.MAP, ", i18n(" factors."), ", sep=\"\"))\n\n"
  ),
  rk.JS.header("Statistics", level=4),
  echo("rk.results(vss.stat.results)\n\n")
)

## make a whole component
vss.component <- rk.plugin.component("Very Simple Structure/Minimum Average Partial",
  xml=list(
    logic=vss.lgc.sect,
    dialog=vss.full.dialog),
  js=list(
    require="psych",
    calculate=vss.js.calc,
    printout=vss.js.print),
  guess.getter=guess.getter,
  hierarchy=list("analysis", "Factor analysis","Number of factors"),
  create=c("xml", "js"))

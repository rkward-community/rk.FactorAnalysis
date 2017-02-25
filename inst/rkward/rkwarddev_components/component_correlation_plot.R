############
## correlation plot
############
# name of the active component, relevant for help page content
rk.set.comp("Correlation plot")

crpltData <- rk.XML.varselector(label="Select data", id.name="crpltData")
crpltDataSelected <- rk.XML.varslot(label="Data (correlation/factor matrix)",
  source=crpltData,
#  classes=c("data.frame", "matrix"),
  required=TRUE,
  id.name="crpltDataSelected")

crpltMainTitle <- rk.XML.input(label="Main title", initial="Correlation plot", id.name="crpltMainTitle")

colors <- rk.XML.radio(label="Colors",
  options=list(
    "Red to Blue"=c(val="true", chk=TRUE),
    "Greyscale"=c(val="false")
  ),
  id.name="colors"
)
numShades <- rk.XML.spinbox(label="Number of shades", min=2, initial=51, real=FALSE, id.name="numShades")

spinLower <- rk.XML.spinbox(label="from", min=-1, max=1, initial=-1, id.name="spinLower")
spinUpper <- rk.XML.spinbox(label="to", min=-1, max=1, initial=1, id.name="spinUpper")
rangeToColor <- rk.XML.frame(
  rk.XML.row(
    rk.XML.col(
      spinLower,
      id.name="clmSpnbxlower"
    ),
    rk.XML.col(
      spinUpper,
      id.name="clmSpnbxupper"
    )
  ),
  label="Range of correlation values to color",
  id.name="rangeToColor"
)

numCat <- rk.XML.spinbox(label="Number of categories in legend", min=1, initial=10, real=FALSE, id.name="numCat")

crplt.preview <- rk.XML.preview()

crplt.full.dialog <- rk.XML.dialog(
  rk.XML.row(
    crpltData,
    rk.XML.col(
      crpltDataSelected,
      colors,
      rangeToColor,
      numShades,
      rk.XML.stretch(),
      crpltMainTitle,
      crpltShowLegend <- rk.XML.frame(
        numCat,
        checkable=TRUE,
        chk=TRUE,
        label="Show legend",
        id.name="crpltShowLegend"),
      crplt.preview
    )
  ),
  label="Correlation plot")

## JavaScript
crplt.js.print <- rk.paste.JS(
  js.chk.lables <- rk.JS.vars(crpltShowLegend, modifiers="checked"),
  rk.paste.JS.graph(
    echo("\t\tcor.plot("),
    js(
      if(crpltDataSelected){
        echo("\n\t\t\tr=", crpltDataSelected)
      } else {},
      if(colors == "false"){
        echo(",\n\t\t\tcolors=FALSE")
      } else {},
      if(numShades != 51){
        echo(",\n\t\t\tn=",numShades)
      } else {},
      if(crpltMainTitle != "Correlation plot"){
        echo(",\n\t\t\tmain=\"", crpltMainTitle, "\"")
      } else {},
      if(spinLower != id(-1) || spinUpper != 1){
        echo(",\n\t\t\tzlim=c(",spinLower,",",spinUpper, ")")
      } else {},
      if(js.chk.lables){
        if(numCat != 10){
          echo(",\n\t\t\tn.legend=", numCat)
        } else {}
      } else {
        echo(",\n\t\t\tshow.legend=FALSE")
      }
    ),
    echo("\n\t\t)")
  )
)

## make a whole component
crplt.component <- rk.plugin.component("Correlation plot",
  xml=list(
    dialog=crplt.full.dialog),
  js=list(results.header="Correlation plot",
    require="psych",
     printout=crplt.js.print),
  guess.getter=guess.getter,
  hierarchy=list("plots", "Factor analysis"),
  create=c("xml", "js"))

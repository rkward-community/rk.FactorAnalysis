############
## scree plot
############
# name of the active component, relevant for help page content
rk.set.comp("Scree plot")

screeData <- rk.XML.varselector(label="Select data.frame", id.name="screeData")
screeDataSelected <- rk.XML.varslot(label="Data", source=screeData, required=TRUE, id.name="screeDataSelected")

screeType <- rk.XML.radio(label="Draw scree for",
  options=list(
    "Factors and components"=c(val="both"),
    "Factors only"=c(val="fact"),
    "Prinicipal components only"=c(val="comp")
  ),
  id.name="screeType"
)

mainTitle <- rk.XML.input(label="Main title", initial="Scree plot", id.name="mainTitle")

horizLine <- rk.XML.frame(
  eigenvalue <- rk.XML.spinbox(
    label="Eigenvalue",
    min=0,
    initial=1,
    id.name="eigenvalue"
  ),
  checkable=TRUE,
  chk=TRUE,
  label="Horizontal line",
  id.name="horizLine"
)

scree.preview <- rk.XML.preview()

scree.full.dialog <- rk.XML.dialog(
  rk.XML.row(
    screeData,
    rk.XML.col(
      screeDataSelected,
      mainTitle,
      screeType,
      horizLine,
      rk.XML.stretch(),
      scree.preview
#       rk.XML.frame(var.dv, var.wid),
#       rk.XML.frame(var.within, var.between)
    )
  )
, label="Scree plot")

## JavaScript
scree.js.print <- rk.paste.JS(
  scree.chk.hline <- rk.JS.vars(horizLine, modifiers="checked"),
  rk.paste.JS.graph(
    echo("\t\tscree("),
    js(
      if(screeDataSelected){
        echo("\n\t\t\t", screeDataSelected)
      } else {},
      if(screeType == "comp"){
        echo(",\n\t\t\tfactors=FALSE")
      } else {},
      if(screeType == "fact"){
        echo(",\n\t\t\tpc=FALSE")
      } else {},
      if(mainTitle != "Scree plot"){
        echo(",\n\t\t\tmain=\"", mainTitle, "\"")
      } else {},
      if(scree.chk.hline){
        if(eigenvalue != 1){
          echo(",\n\t\t\thline=", eigenvalue)
        } else {}
      } else {
        echo(",\n\t\t\thline=-1")
      }
    ),
    echo(")")
  )
)

## make a whole component
scree.component <- rk.plugin.component("Scree plot",
  xml=list(
    dialog=scree.full.dialog
  ),
  js=list(
    require="psych",
    printout=scree.js.print
  ),
  guess.getter=guess.getter,
  hierarchy=list("analysis", "Factor analysis","Number of factors"),
  create=c("xml", "js")
)

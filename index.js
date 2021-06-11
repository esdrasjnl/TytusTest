var config, editor;
var result,

config = {
    lineNumbers: true,
    mode: "text/html",
    theme: "ambiance",
    indentWithTabs: false,
    readOnly: false,
    mode: "xml",
    autoCloseBrackets: true
};

editor = CodeMirror.fromTextArea(document.getElementById("entrada"), config);

function analizaXML() {
    try {
        document.getElementById("console").value = "";
        result = XmlAsc.parse(editor.getValue());
        console.log(result);
    } catch (error) {
        
    }
}

function reporteAst(){
    let arbol = new AST();
    let graficar = arbol.generarDot(result);
    var clickedTab = document.getElementById("clickedTab");
    clickedTab.innerHTML = "";
    clickedTab.innerHTML = "<h3>Reporte AST</h3>"

    //console.log(graficar);
    var viz = new Viz();
    viz.renderSVGElement(graficar).then(function (element) {
      clickedTab.appendChild(element);
    })
    .catch((error) => {
      console.error(error);
    });

}
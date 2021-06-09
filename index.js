
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
        console.log("Hola Mundo");   
        result = gramatica.parse(editor.getValue());
    } catch (error) {
        
    }
}
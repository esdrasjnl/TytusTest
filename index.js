
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
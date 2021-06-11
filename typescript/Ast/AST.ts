class AST{
    private i:number;

    constructor(){
        this.i = 0;
    }

    public generarDot(raiz:Nodo):string{
        var dotReporte:string = "digraph Arbol_AST{ node[shape=\"box\"]";
        dotReporte += this.dotArbol(raiz);
        dotReporte += "}";
        return dotReporte;
    }

    public dotArbol(raiz:Nodo):string{
        var cuerpoRecorridoArbol:string = "";
        this.i++;
        var padre:string = "n"+this.i;

        if( raiz.getValor() != null )
            cuerpoRecorridoArbol += padre + "[label = \"" + raiz.getNombre() + "\\n" + raiz.getValor() + "\"];";
        else
            cuerpoRecorridoArbol += padre + "[label = \"" + raiz.getNombre() + "\"];";
        
        
        for(let nodo of raiz.getHijos()){
            cuerpoRecorridoArbol += padre + " -> n" + (this.i + 1) + ";\n";
            cuerpoRecorridoArbol += this.dotArbol(nodo);
        }

        return cuerpoRecorridoArbol;
    }

}
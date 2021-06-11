
class Simbolo {
    public indentificador: string;
    private valor: any;
    private tipo: Tipo;
    linea: number;
    columna: number;

    constructor(tipo:Tipo, id:string, linea:number, columna:number){
        this.indentificador = id;
        this.linea = linea;
        this.columna = columna;
        this.tipo = tipo;
    }

    getTipo(): Tipo {
        return this.tipo;
    }
    getValorImplicito() {
        return this.valor;
    }
    
}
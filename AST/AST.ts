export abstract class Nodo{
    fila:number;
    columna:number;
    nombre:string;
    valor:any;
    hijos:Array<Nodo>;

    constructor(fila:number, columna:number, nombre:string, valor:any){
        this.fila = fila;
        this.columna = columna;
        this.nombre = nombre;
        this.valor = valor;
        this.hijos = [];
    }

}
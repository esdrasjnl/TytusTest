import { Entorno } from '../Entorno/Entorno';

export abstract class Nodo{
    
    private fila:number;
    private columna:number;
    private nombre:string;
    private valor:any;
    private hijos:Array<Nodo>;

    constructor(fila:number, columna:number, nombre:string, valor:any){
        this.fila = fila;
        this.columna = columna;
        this.nombre = nombre;
        this.valor = valor;
        this.hijos = [];
    }

    abstract ejecutar(entorno:Entorno):any;

    public setFila(fila:number):void{
        this.fila = fila;
    }

    public getFila():number{
        return this.fila
    }

    public setColumna(columna:number):void{
        this.columna = columna;
    }

    public getColumna():number{
        return this.columna;
    }

    public setNombre(nombre:string):void{
        this.nombre = nombre;
    }

    public getNombre():string{
        return this.nombre;
    }

    public setValor(valor:any):void{
        this.valor = valor;
    }

    public getValor():any{
        return this.valor;
    }

    public setHijos(hijos:Array<Nodo>):void{
        this.hijos = hijos;
    }

    public getHijos():Array<Nodo>{
        return this.hijos;
    }

}
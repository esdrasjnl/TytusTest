import { Nodo } from '../Ast/Nodo';
import { Tipo } from '../Entorno/Tipo';
import { Entorno } from '../Entorno/Entorno';

export class Expresion extends Nodo{

    private valueExp:any;
    private tipoExp:Tipo;

    constructor(fila:number,columna:number,nombre:string, valor:any, valueExp:any){
        super(fila, columna, nombre, valor);
        this.valueExp = valueExp;
        this.tipoExp = Tipo.VOID;
    }

    ejecutar(entorno:Entorno){

    }

}
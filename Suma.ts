import { Expresion } from "./Expresion";

export class Suma implements Expresion{
    valor1: number;
    valor2: number;
    
    constructor(val1: number, val2: number) {
        this.valor1 = val1;
        this.valor2 = val2;
    }

    obtenerValor(): number {
        return this.valor1 + this.valor2;
    }
    
}
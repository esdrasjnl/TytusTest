import { Expresion } from "./Expresion";
import { Resta } from "./Resta";
import { Suma } from "./Suma";

const suma:Expresion = new Suma(1,2);
const resta:Resta = new Resta(4,1);

console.log('Suma: ', suma.obtenerValor());

console.log('Resta: ', resta.obtenerValor());
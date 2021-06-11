class Cadena extends Expresion{

    constructor(fila:number, columna:number, valor:any){
        super(fila,columna,"Cadena",valor);
        this.getTipo().setType(Tipo_Enum.STRING);
        this.setValueExp(valor);
    }

    ejecutar(entorno:Entorno){

    }

}
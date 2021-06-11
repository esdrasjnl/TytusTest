class Expresion extends Nodo{

    private valueExp:any;
    private tipoExp:Tipo;

    constructor(fila:number,columna:number,nombre:string, valor:any){
        super(fila, columna, nombre, valor);
        this.tipoExp = new Tipo();
    }

    ejecutar(entorno:Entorno){
        
    }

    public getTipo():Tipo{
        return this.tipoExp;
    }

    public setTipo(tipoExp:Tipo):void{
        this.tipoExp = tipoExp;
    }

    public getValueExp():any{
        return this.valueExp;
    }

    public setValueExp(valueExp:any){
        this.valueExp = valueExp;
    }

}
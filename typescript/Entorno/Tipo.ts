enum Tipo_Enum {
    STRING,
    INT, 
    DOUBLE,
    BOOL,
    VOID,
    STRUCT,
    ARRAY
}

class Tipo{

    private type:Tipo_Enum;

    constructor(){
        this.type = Tipo_Enum.VOID;
    }

    public setType(type:Tipo_Enum):void{
        this.type = type;
    }

    public getType():Tipo_Enum{
        return this.type;
    }

}
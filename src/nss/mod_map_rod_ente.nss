const string TYPE_TRAP = "trap_en_36_";

void CreaPosizionabiliFOR(object oArea,int NumeroOggettiRand,int NumeroOggettiMin,int NumeroTappeMin,int NumeroTappeMax,string VALORE)
{
    object oWay,oPos;
    int i,nRandom,nTrap,nTypeTrap;
    string sTRA,sRefOBJ,sWAY;
    string sArea = GetTag(oArea);
    string sStringOBJ = "rodon_ps";
    string sStringTRA = "rodon_pt";
    string sStringWAY = "rodon_t";
    string sTypeTrap = TYPE_TRAP;
        for(i=NumeroTappeMin;i<=NumeroTappeMax;i++){
            sWAY = sStringWAY + VALORE + IntToString(i);
            //Dove Creare i Posizionabili
            oWay = GetObjectByTag(sWAY);
            nRandom = Random(NumeroOggettiRand)+NumeroOggettiMin;
            sRefOBJ = sStringOBJ + IntToString(nRandom);
            //Creazione Posizionabile
            oPos = CreateObject(OBJECT_TYPE_PLACEABLE,sRefOBJ,GetLocation(oWay));
            nTrap = d4(1);
            //Se esce uno  una trappola e settiamo la variabile
            if(nTrap == 1){
                nTypeTrap = Random(5)+1;
                switch(nTypeTrap){
                    case 1:
                        sTypeTrap = sTypeTrap + "frost";
                        break;
                    case 2:
                        sTypeTrap = sTypeTrap + "sonic";
                        break;
                    case 3:
                        sTypeTrap = sTypeTrap + "fire";
                        break;
                    case 4:
                        sTypeTrap = sTypeTrap + "elec";
                        break;
                    case 5:
                        sTypeTrap = sTypeTrap + "acid";
                        break;
                }
                AssignCommand(oArea,ApplyEffectAtLocation(DURATION_TYPE_PERMANENT,EffectAreaOfEffect(AOE_PER_CUSTOM_AOE,sTypeTrap,"",""),GetLocation(oPos)));
            }
        }
}

void CreaPosizionabili(object oArea)
{
    string sArea = GetTag(oArea);
    if(sArea == "dun_cov_ban"){
        CreaPosizionabiliFOR(oArea,4,0,0,7,"1");
        CreaPosizionabiliFOR(oArea,3,4,8,12,"1");
        CreaPosizionabiliFOR(oArea,3,7,13,15,"1");
    }
    else if(sArea == "dun_cov_ban_sup"){
        CreaPosizionabiliFOR(oArea,21,0,0,15,"2");
    }
    else if(sArea == "dun_cov_ban_nas"){
        CreaPosizionabiliFOR(oArea,3,10,0,5,"3");
        CreaPosizionabiliFOR(oArea,0,0,6,10,"3");
        CreaPosizionabiliFOR(oArea,5,13,11,16,"3");
        CreaPosizionabiliFOR(oArea,3,18,17,20,"3");
        CreaPosizionabiliFOR(oArea,21,0,21,26,"3");
    }
}
void main()
{
    object oArea = OBJECT_SELF;
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == TRUE && GetIsDM(oPC) == FALSE){
        SetLocalObject(oPC,"script_rodon_exit",oArea);
        int NumeroPC = GetLocalInt(oArea,"script_rodon");
        int NumeroPCNow = NumeroPC+1;
        SetLocalInt(oArea,"script_rodon",NumeroPCNow);
        if(NumeroPCNow == 1)
            CreaPosizionabili(oArea);
    }
}


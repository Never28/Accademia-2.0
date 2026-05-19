void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

void RimuoviTrap(object oArea)
{
    object oTarget = GetFirstObjectInArea(oArea);
    while(oTarget!=OBJECT_INVALID){
        if(GetObjectType(oTarget)==OBJECT_TYPE_AREA_OF_EFFECT||(GetObjectType(oTarget)==OBJECT_TYPE_PLACEABLE&&GetLocalInt(oTarget,"not_trap")==0))
            SafeDestroyObject(oTarget,0.0);
        oTarget =GetNextObjectInArea(oArea);
    }

}

void main()
{
    // la Mappa.
    object oArea = OBJECT_SELF;
    // Il giocatore che Esce.
    object oPC = GetExitingObject();
    if(GetIsPC(oPC) == TRUE && GetIsDM(oPC) == FALSE){
        DeleteLocalObject(oPC,"script_rodon_exit");
        // Vediamo i giocatori presenti prima della sua uscita e sottraiamo l'uscita.
        int NumeroPC = GetLocalInt(oArea,"script_rodon");
        int NumeroPCNow = NumeroPC-1;
        // Sottraiamo quello che esce.
        SetLocalInt(oArea,"script_rodon",NumeroPCNow);
        // Se il numero e' pari a zero facciamo partire lo script che cancella tutto quello che era stato creato nell'area
        if(NumeroPCNow == 0){
            RimuoviTrap(oArea);
        }
    }
}

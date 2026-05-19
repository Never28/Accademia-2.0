void SafeDestroyObject(object oObject)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject))
        DelayCommand(0.0,SetPlotFlag(oObject, FALSE));
    if(GetImmortal(oObject))
        DelayCommand(0.0,SetImmortal(oObject, FALSE));
    if(!GetDroppableFlag(oObject))
        DelayCommand(0.0,SetDroppableFlag(oObject, TRUE));
    DestroyObject(oObject);
}

void main()
{
    object oArea = OBJECT_SELF;
    int nArea = GetLocalInt(oArea,"AREAPG");
    int nCount = 0;
    if(nArea == 1){
        object oPC = GetFirstPC();
        while(GetIsObjectValid(oPC)){
            object oAreaPC = GetArea(oPC);
            int nDadoProva = d6(1);
            if(nDadoProva==1){
                if(oArea == oAreaPC){
                    //Se non si supera la prova di riflessi creiamo la buca e facciamo andare il PG al piano di sotto
                    if(ReflexSave(oPC,47,SAVING_THROW_TYPE_NONE,oArea)==0){
                        object oBuca = CreateObject(OBJECT_TYPE_PLACEABLE,"mod_door_che",GetLocation(oPC));
                        int nAcrobazia = GetSkillRank(SKILL_TUMBLE,oPC);
                        int nDado = d20(1);
                        int nTotale = nAcrobazia + nDado;
                        if(nDado=1){
                            SendMessageToPC(oPC,"Tiro di Acrobazia per la Caduta: "+IntToString(nDado)+"+"+IntToString(nAcrobazia)+"="+IntToString(nTotale)+" Fallimento Critico");
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oPC);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DEATH),oPC);
                        }
                        else{
                            if(nTotale<47){
                                SendMessageToPC(oPC,"Tiro di Acrobazia per la Caduta: "+IntToString(nDado)+"+"+IntToString(nAcrobazia)+"="+IntToString(nTotale)+" CD 47 Prova Fallita");
                            }
                            else{
                                SendMessageToPC(oPC,"Tiro di Acrobazia per la Caduta: "+IntToString(nDado)+"+"+IntToString(nAcrobazia)+"="+IntToString(nTotale)+" CD 47 Prova Superata");
                            }
                        }
                        DelayCommand(60.0,SafeDestroyObject(oBuca));
                    }
                }
            }
            oPC = GetNextPC();
        }
    }
    if(nCount == 0)
        SetLocalInt(oArea,"AREAPG",0);
    else
        DelayCommand(12.0,ExecuteScript("mod_bas_acq_a",oArea));
}

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
            int nDadoProva = d10(1);
            if(GetIsDM(oPC)==FALSE){
                if(nDadoProva==1){
                    if(oArea == oAreaPC){
                        nCount = 1;
                        //Se non si supera la prova di riflessi creiamo la buca e facciamo andare il PG al piano di sotto
                        if(ReflexSave(oPC,47,SAVING_THROW_TYPE_NONE,oArea)==0){
                            int nAcrobazia = GetSkillRank(SKILL_TUMBLE,oPC);
                            int nDado = d20(1);
                            int nTotale = nAcrobazia + nDado;
                            if(nDado==1){
                                object oBuca = CreateObject(OBJECT_TYPE_PLACEABLE,"mod_door_che",GetLocation(oPC));
                                DelayCommand(60.0,SafeDestroyObject(oBuca));
                                string sArea = GetTag(oArea);
                                string sZone;
                                if(sArea == "dun_che_sup"){
                                    SendMessageToPC(oPC,"Tiro di Acrobazia per la Caduta: "+IntToString(nDado)+"+"+IntToString(nAcrobazia)+"="+IntToString(nTotale)+" Fallimento Critico");
                                    sZone = "dun_che_bib_t1";
                                }
                                else
                                    sZone = "dun_che_mag_t1";
                                object oTarget = GetWaypointByTag(sZone);
                                DelayCommand(0.0, AssignCommand(oPC, ClearAllActions(TRUE)));
                                DelayCommand(0.1, AssignCommand(oPC, ActionJumpToObject(oTarget)));
                                SetLocalInt(GetArea(oTarget),"CADUTA",1);
                            }
                            else{
                                if(nTotale<47){
                                    object oBuca = CreateObject(OBJECT_TYPE_PLACEABLE,"mod_door_che",GetLocation(oPC));
                                    DelayCommand(60.0,SafeDestroyObject(oBuca));
                                    string sArea = GetTag(oArea);
                                    string sZone;
                                    if(sArea == "dun_che_sup"){
                                        sZone = "dun_che_bib_t1";
                                        SendMessageToPC(oPC,"Tiro di Acrobazia per la Caduta: "+IntToString(nDado)+"+"+IntToString(nAcrobazia)+"="+IntToString(nTotale)+" CD 47 Prova Fallita");
                                    }
                                    else
                                        sZone = "dun_che_mag_t1";
                                    object oTarget = GetWaypointByTag(sZone);
                                    DelayCommand(0.0, AssignCommand(oPC, ClearAllActions(TRUE)));
                                    DelayCommand(0.1, AssignCommand(oPC, ActionJumpToObject(oTarget)));
                                    SetLocalInt(GetArea(oTarget),"CADUTA",2);
                                }
                                else{
                                    SendMessageToPC(oPC,"Tiro di Acrobazia per la Caduta: "+IntToString(nDado)+"+"+IntToString(nAcrobazia)+"="+IntToString(nTotale)+" CD 47 Prova Superata");
                                }
                            }
                        }
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

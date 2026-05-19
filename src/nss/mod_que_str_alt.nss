int nControllSpell(int nSpell_o,int nSpell_c){
    if((nSpell_o == 1 && nSpell_c == SPELL_FLAME_ARROW) ||
    (nSpell_o == 2 && nSpell_c == SPELL_ICE_DAGGER) ||
    (nSpell_o == 3 && nSpell_c == SPELL_ELECTRIC_JOLT) ||
    (nSpell_o == 4 && nSpell_c == SPELL_LIGHTNING_BOLT) ||
    (nSpell_o == 5 && nSpell_c == SPELL_MAGIC_MISSILE) ||
    (nSpell_o == 6 && nSpell_c == SPELL_RAY_OF_FROST) ||
    (nSpell_o == 7 && nSpell_c == SPELL_BIGBYS_INTERPOSING_HAND) ||
    (nSpell_o == 8 && nSpell_c == SPELL_DOMINATE_MONSTER) ||
    (nSpell_o == 9 && nSpell_c == SPELL_ENERVATION) ||
    (nSpell_o == 10 && nSpell_c == SPELL_CLARITY))
        return 1;
    return 0;
}

void RemoveAll(object oObj){
    effect eEff = GetFirstEffect(oObj);
    while(GetIsEffectValid(eEff)==TRUE){
        RemoveEffect(oObj,eEff);
        eEff = GetNextEffect(oObj);
    }
}

void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

void main()
{
    object oSantuario = OBJECT_SELF;
    int nLastSpell = GetLastSpell();
    int nSpell1 = GetLocalInt(GetModule(),"n_spell_s1");
    int nSpell2 = GetLocalInt(GetModule(),"n_spell_s2");
    int nSpell3 = GetLocalInt(GetModule(),"n_spell_s3");
        int nNumberSpell = GetLocalInt(GetModule(),"Quest_Strega_Spell");
        switch(nNumberSpell){
            case 0:
                if(nControllSpell(nSpell1,nLastSpell)==1)
                    SetLocalInt(GetModule(),"Quest_Strega_Spell", 1);
                else
                    SetLocalInt(GetModule(),"Quest_Strega_Spell", 4);
                break;
            case 1:
                if(nControllSpell(nSpell2,nLastSpell)==1)
                    SetLocalInt(GetModule(),"Quest_Strega_Spell", 2);
                else
                    SetLocalInt(GetModule(),"Quest_Strega_Spell", 5);
                break;
            case 2:
                if(nControllSpell(nSpell3,nLastSpell)==1){
                    SetLocalInt(GetModule(),"Quest_Strega_Spell", 3);
                    DelayCommand(0.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_HEALING_X), oSantuario));
                    object oObj = GetFirstObjectInArea(GetArea(oSantuario));
                    while(oObj != OBJECT_INVALID){
                        if(GetObjectType(oObj) == OBJECT_TYPE_PLACEABLE && (GetTag(oObj) == "col_str_1"||GetTag(oObj) == "col_str_2")){
                            SafeDestroyObject(oObj,0.0);
                            DelayCommand(0.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_KNOCK), oObj));
                        }
                        oObj = GetNextObjectInArea(GetArea(oSantuario));
                    }
                    DelayCommand(1.0,RemoveAll(oSantuario));
                }
                else{
                    effect eDrain = EffectNegativeLevel(10);
                    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
                    eVis = EffectLinkEffects(eVis,eDrain);
                    DelayCommand(0.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_HARM), oSantuario));
                    object oPC = GetFirstObjectInArea(GetArea(oSantuario));
                    while(oPC != OBJECT_INVALID){
                        if(GetIsPC(oPC)==TRUE){
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPC);
                        }
                        oPC = GetNextObjectInArea(GetArea(oSantuario));
                    }
                    DelayCommand(1.0,RemoveAll(oSantuario));
                    object oItem = CreateObject(OBJECT_TYPE_CREATURE,"set_48_ssp",GetLocation(GetWaypointByTag("col_str_t3")),VFX_FNF_SUMMON_MONSTER_3);
                    oItem = CreateObject(OBJECT_TYPE_CREATURE,"set_48_ssc",GetLocation(GetWaypointByTag("col_str_t3")),VFX_FNF_SUMMON_MONSTER_3);
                    oItem = CreateObject(OBJECT_TYPE_CREATURE,"set_48_sst",GetLocation(GetWaypointByTag("col_str_t3")),VFX_FNF_SUMMON_MONSTER_3);
                }
                break;
            case 3:
                break;
            case 4:
                SetLocalInt(GetModule(),"Quest_Strega_Spell", 5);
                break;
            case 5:
                SetLocalInt(GetModule(),"Quest_Strega_Spell", 0);
                effect eDrain = EffectNegativeLevel(10);
                DelayCommand(0.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_HARM), oSantuario));
                effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
                eVis = EffectLinkEffects(eVis,eDrain);
                object oPC = GetFirstObjectInArea(GetArea(oSantuario));
                while(oPC != OBJECT_INVALID){
                    if(GetIsPC(oPC)==TRUE){
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oPC);
                    }
                    oPC = GetNextObjectInArea(GetArea(oSantuario));
                }
                DelayCommand(1.0,RemoveAll(oSantuario));
                object oItem = CreateObject(OBJECT_TYPE_CREATURE,"set_48_ssp",GetLocation(GetWaypointByTag("col_str_t3")),VFX_FNF_SUMMON_MONSTER_3);
                oItem = CreateObject(OBJECT_TYPE_CREATURE,"set_48_ssc",GetLocation(GetWaypointByTag("col_str_t3")),VFX_FNF_SUMMON_MONSTER_3);
                oItem = CreateObject(OBJECT_TYPE_CREATURE,"set_48_sst",GetLocation(GetWaypointByTag("col_str_t3")),VFX_FNF_SUMMON_MONSTER_3);
                break;
        }
}

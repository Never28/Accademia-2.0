void main()
{
    object oArea = OBJECT_SELF;
    int nArea = GetLocalInt(oArea,"AREAPG");
    int nCount = 0;
    if(nArea == 1){
        object oPC = GetFirstPC();
        while(GetIsObjectValid(oPC)){
            object oAreaPC = GetArea(oPC);
            if(GetIsDM(oPC)==FALSE){
                if(oArea == oAreaPC){
                    int nForm = GetAppearanceType(oPC);
                    if(nForm!= APPEARANCE_TYPE_DRAGON_BLUE &&nForm!= APPEARANCE_TYPE_WYRMLING_BLUE &&
                    nForm!= APPEARANCE_TYPE_ELEMENTAL_AIR && nForm!= APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER &&
                    nForm!= APPEARANCE_TYPE_ELEMENTAL_EARTH && nForm!= APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER &&
                    nForm!= APPEARANCE_TYPE_ELEMENTAL_WATER && nForm!= APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER){
                        if ((GetRacialType(oPC) == RACIAL_TYPE_UNDEAD || GetRacialType(oPC) == RACIAL_TYPE_CONSTRUCT)||
                        nForm == APPEARANCE_TYPE_SKELETON_CHIEFTAIN || nForm == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 ||
                        nForm == APPEARANCE_TYPE_MOHRG || nForm == APPEARANCE_TYPE_MUMMY_GREATER ||
                        nForm == APPEARANCE_TYPE_VAMPIRE_MALE || nForm == APPEARANCE_TYPE_VAMPIRE_FEMALE ||
                        nForm == APPEARANCE_TYPE_LICH || nForm == APPEARANCE_TYPE_MINDFLAYER_ALHOON ||
                        nForm == APPEARANCE_TYPE_DEMI_LICH || nForm == APPEARANCE_TYPE_GOLEM_BONE ||
                        nForm == APPEARANCE_TYPE_DRACOLICH || nForm == APPEARANCE_TYPE_GOLEM_ADAMANTIUM ||
                        nForm == APPEARANCE_TYPE_GOLEM_DEMONFLESH || nForm == APPEARANCE_TYPE_GOLEM_IRON ||
                        nForm == APPEARANCE_TYPE_GOLEM_MITHRAL || nForm == APPEARANCE_TYPE_SHIELD_GUARDIAN){

                        }
                        else{
                            if(GetIsDead(oPC)==FALSE){
                                int nCurrentDC = GetLocalInt(oPC,"ANNEGARE");
                                int nAnnegamenti = GetLocalInt(oPC,"NUMEROANNEGAMENTI");
                                int nAnnego = GetLocalInt(oPC,"STOANNEGANDO");
                                int nNewDC = nCurrentDC +2;
                                int nCostituzione = GetAbilityModifier(ABILITY_CONSTITUTION,oPC);
                                int n20Roll = d20(1);
                                int nProva = nCostituzione + n20Roll;
                                SetLocalInt(oPC,"ANNEGARE",nNewDC);
                                if(nAnnego==0){
                                    if(nProva < nNewDC){
                                        int nDanno = 50*(nAnnegamenti);
                                        SetLocalInt(oPC,"NUMEROANNEGAMENTI",nAnnegamenti+1);
                                        SetLocalInt(oPC,"STOANNEGANDO",1);
                                        effect eDamage = EffectDamage(nDanno,DAMAGE_TYPE_MAGICAL);
                                        effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
                                        eDamage = EffectLinkEffects(eDamage,eVis);
                                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oPC);
                                        SendMessageToPC(oPC,"Tiro di Costituzione per Annegamento: "+IntToString(n20Roll)+"+"+IntToString(nCostituzione)+"="+IntToString(nProva)+" Contro CD ="+IntToString(nNewDC)+" Fallito");
                                    }
                                    else{
                                        SendMessageToPC(oPC,"Tiro di Costituzione per Annegamento: "+IntToString(n20Roll)+"+"+IntToString(nCostituzione)+"="+IntToString(nProva)+" Contro CD ="+IntToString(nNewDC)+" Superato");
                                    }
                                }
                                else{
                                    int nDanno = 50*(nAnnegamenti);
                                    SetLocalInt(oPC,"NUMEROANNEGAMENTI",nAnnegamenti+1);
                                    effect eDamage = EffectDamage(nDanno,DAMAGE_TYPE_MAGICAL);
                                    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
                                    eDamage = EffectLinkEffects(eDamage,eVis);
                                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oPC);
                                }
                            }
                        }
                    }
                    int i=1;
                    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
                    while(GetIsObjectValid(oSummon)){
                        oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
                        int nForm = GetAppearanceType(oSummon);
                        if(nForm!= APPEARANCE_TYPE_DRAGON_SILVER&&nForm!= APPEARANCE_TYPE_DRAGON_WHITE&&
                        nForm!= APPEARANCE_TYPE_WYRMLING_SILVER&&nForm!= APPEARANCE_TYPE_WYRMLING_WHITE&&
                        nForm!= APPEARANCE_TYPE_GIANT_FROST&&nForm!= APPEARANCE_TYPE_GIANT_FROST_FEMALE){
                            if ((GetRacialType(oSummon) == RACIAL_TYPE_UNDEAD || GetRacialType(oSummon) == RACIAL_TYPE_CONSTRUCT)||
                            nForm == APPEARANCE_TYPE_SKELETON_CHIEFTAIN || nForm == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 ||
                            nForm == APPEARANCE_TYPE_MOHRG || nForm == APPEARANCE_TYPE_MUMMY_GREATER ||
                            nForm == APPEARANCE_TYPE_VAMPIRE_MALE || nForm == APPEARANCE_TYPE_VAMPIRE_FEMALE ||
                            nForm == APPEARANCE_TYPE_LICH || nForm == APPEARANCE_TYPE_MINDFLAYER_ALHOON ||
                            nForm == APPEARANCE_TYPE_DEMI_LICH || nForm == APPEARANCE_TYPE_GOLEM_BONE ||
                            nForm == APPEARANCE_TYPE_DRACOLICH || nForm == APPEARANCE_TYPE_GOLEM_ADAMANTIUM ||
                            nForm == APPEARANCE_TYPE_GOLEM_DEMONFLESH || nForm == APPEARANCE_TYPE_GOLEM_IRON ||
                            nForm == APPEARANCE_TYPE_GOLEM_MITHRAL || nForm == APPEARANCE_TYPE_SHIELD_GUARDIAN){

                            }
                            else{


                            }
                        }
                        i++;
                    }
                    nCount = 1;
                }
            }
            oPC = GetNextPC();
        }
    }
    if(nCount == 0)
        SetLocalInt(oArea,"AREAPG",0);
    else
        DelayCommand(12.0,ExecuteScript("mod_bas_acq_c",oArea));
}

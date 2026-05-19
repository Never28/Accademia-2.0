void main()
{
    object oArea = OBJECT_SELF;
    int nArea = GetLocalInt(oArea,"AREAPG");
    int nCount = 0;
    if(nArea == 1){
        object oPC = GetFirstPC();
        while(GetIsObjectValid(oPC)){
            object oAreaPC = GetArea(oPC);
            if(oArea == oAreaPC){
                int nDamage = d12(2);
                effect eFrost = EffectDamage(nDamage,DAMAGE_TYPE_COLD);
                effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
                effect eVis2 = EffectVisualEffect(VFX_DUR_ICESKIN);
                effect eSlow = SupernaturalEffect(EffectSlow());
                effect eRall = EffectMovementSpeedDecrease(50);
                eFrost = EffectLinkEffects(eFrost,eVis);
                eSlow = EffectLinkEffects(eSlow,eVis2);
                eSlow = EffectLinkEffects(eRall,eVis2);
                int nForm = GetAppearanceType(oPC);
                if(nForm!= APPEARANCE_TYPE_DRAGON_SILVER&&nForm!= APPEARANCE_TYPE_DRAGON_WHITE&&
                nForm!= APPEARANCE_TYPE_WYRMLING_SILVER&&nForm!= APPEARANCE_TYPE_WYRMLING_WHITE&&
                nForm!= APPEARANCE_TYPE_GIANT_FROST&&nForm!= APPEARANCE_TYPE_GIANT_FROST_FEMALE){
                    if ((GetRacialType(oPC) == RACIAL_TYPE_UNDEAD || GetRacialType(oPC) == RACIAL_TYPE_CONSTRUCT)||
                    nForm == APPEARANCE_TYPE_SKELETON_CHIEFTAIN || nForm == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 ||
                    nForm == APPEARANCE_TYPE_MOHRG || nForm == APPEARANCE_TYPE_MUMMY_GREATER ||
                    nForm == APPEARANCE_TYPE_VAMPIRE_MALE || nForm == APPEARANCE_TYPE_VAMPIRE_FEMALE ||
                    nForm == APPEARANCE_TYPE_LICH || nForm == APPEARANCE_TYPE_MINDFLAYER_ALHOON ||
                    nForm == APPEARANCE_TYPE_DEMI_LICH || nForm == APPEARANCE_TYPE_GOLEM_BONE ||
                    nForm == APPEARANCE_TYPE_DRACOLICH || nForm == APPEARANCE_TYPE_GOLEM_ADAMANTIUM ||
                    nForm == APPEARANCE_TYPE_GOLEM_DEMONFLESH || nForm == APPEARANCE_TYPE_GOLEM_IRON ||
                    nForm == APPEARANCE_TYPE_GOLEM_MITHRAL || nForm == APPEARANCE_TYPE_SHIELD_GUARDIAN){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrost,oPC);
                    }
                    else{
                        if(FortitudeSave(oPC,48,SAVING_THROW_TYPE_COLD,oArea)==0){
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrost,oPC);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oPC,6.0);
                        }
                    }
                }
                int i=1;
                object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
                while(GetIsObjectValid(oSummon)){
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrost,oSummon);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oSummon,6.0);
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
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrost,oSummon);
                        }
                        else{
                            if(FortitudeSave(oPC,48,SAVING_THROW_TYPE_COLD,oArea)==0){
                                ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrost,oSummon);
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oSummon,6.0);
                            }
                        }
                    }
                    i++;
                }
                nCount = 1;
            }
            oPC = GetNextPC();
        }
    }
    if(nCount == 0)
        SetLocalInt(oArea,"AREAPG",0);
    else
        DelayCommand(12.0,ExecuteScript("mod_bas_giant_a",oArea));
}

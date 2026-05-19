void main()
{
    object oPC = GetEnteringObject();
    string oName= GetPCPlayerName(oPC);
    object oHorse = GetObjectByTag(oName+"i");
    ExecuteScript("mod_bas_horse_de",oHorse);
    SetLocalInt(oPC,"HorseMap",1);
    int nPheno = GetPhenoType(oPC);
    switch(nPheno){
        case 10: case 11: case 12: case 13: case 14: case 15: case 17: case 18:
            SetPhenoType(0,oPC);
            if(GetItemPossessedBy(oPC,"mod_clas_cv")!=OBJECT_INVALID)
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageDecrease(DAMAGE_BONUS_20,DAMAGE_TYPE_MAGICAL)),oPC);
            break;
        case 27: case 28: case 30: case 31: case 32: case 33: case 34: case 35:
            SetPhenoType(2,oPC);
            if(GetItemPossessedBy(oPC,"mod_clas_cv")!=OBJECT_INVALID)
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageDecrease(DAMAGE_BONUS_20,DAMAGE_TYPE_MAGICAL)),oPC);
            break;
    }
    object oItem;
    if((oItem = GetItemPossessedBy(oPC,"mod_bas_dismount"))!= OBJECT_INVALID)
        DestroyObject(oItem);
    object oMin1 = GetObjectByTag("rim_tav_1");
    object oMin2 = GetObjectByTag("rim_tav_2");
    object oMin3 = GetObjectByTag("rim_tav_3");
    object oMin4 = GetObjectByTag("rim_tav_4");
    object oMinp1 = GetObjectByTag("rim_tav_1_p");
    object oMinp2 = GetObjectByTag("rim_tav_2_p");
    object oMinp3 = GetObjectByTag("rim_tav_3_p");
    object oMinp4 = GetObjectByTag("rim_tav_4_p");
    AssignCommand(oMin1,ActionSit(oMinp1));
    AssignCommand(oMin2,ActionSit(oMinp2));
    AssignCommand(oMin3,ActionSit(oMinp3));
    AssignCommand(oMin4,ActionSit(oMinp4));
}

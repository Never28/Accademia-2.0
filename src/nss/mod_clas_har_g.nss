void CatapultaEffect(object oTarget,object oPC,effect eDamage2,effect eVis2){
    object oTarget2 = GetFirstObjectInShape(SHAPE_SPHERE,5.0,GetLocation(oTarget));
    while(oTarget2!=OBJECT_INVALID){
        if(GetIsEnemy(oTarget2,oPC)==TRUE&&oTarget2!=oTarget){
            AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage2, oTarget2));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget);
        }
        oTarget2 = GetNextObjectInShape(SHAPE_SPHERE,5.0,GetLocation(oTarget));
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetLocalObject(oPC,"Balista_Target");
    int nDamage;
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD,oPC)+GetLevelByClass(CLASS_TYPE_HARPER,oPC);
    int nSkill = GetSkillRank(SKILL_CRAFT_WEAPON,oPC,TRUE);
    if(nCasterLevel>=40 && nSkill>=43 && GetItemPossessedBy(oPC,"mod_clas_al") != OBJECT_INVALID)
        nDamage = d8(nCasterLevel);
    else if(nCasterLevel>=31 && nSkill>=34)
        nDamage = d6(nCasterLevel);
    else if(nCasterLevel>=21 && nSkill>=24)
        nDamage = d4(nCasterLevel);
    else if(nCasterLevel>=15 && nSkill>=14)
        nDamage = d2(nCasterLevel);
    else
        nDamage = nCasterLevel;
    float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
    float fDamage2 = (IntToFloat(nDamage)/100.0)*60.0;
    nDamage = FloatToInt(fDamage);
    int nDamage2 = FloatToInt(fDamage2);
    effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
    effect eDamage2 = EffectDamage(nDamage2,DAMAGE_TYPE_FIRE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    CatapultaEffect(oTarget,oPC,eDamage2,eVis);
}

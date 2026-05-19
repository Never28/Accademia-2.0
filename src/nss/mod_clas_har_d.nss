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
    effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_PIERCING);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
}

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
                effect eAcid = EffectDamage(nDamage,DAMAGE_TYPE_ACID);
                effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
                eAcid = EffectLinkEffects(eAcid,eVis);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eAcid,oPC);
                int i=1;
                object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
                while(GetIsObjectValid(oSummon)){
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eAcid,oSummon);
                    oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
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
        DelayCommand(12.0,ExecuteScript("mod_bas_troll_a",oArea));
}

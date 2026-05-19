#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCap=4;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF);
    int nDuration = 40;
    effect eSummon;
    if(nCasterLevel>=13)
        nCap =2;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sSummon1;
    string sSummon2;
    string sSummon3;
    string sSummon4;
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
        SetLocalInt(OBJECT_SELF, "CleanEvo",nDuration);
    if(nCasterLevel==30 && nLore>=43)
        eSummon = EffectSummonCreature("sp_blkdead_4");
    else if(nCasterLevel>=21 && nLore>=34)
        eSummon = EffectSummonCreature("sp_blkdead_3");
    else if(nCasterLevel>=11 && nLore>=24)
        eSummon = EffectSummonCreature("sp_blkdead_2");
    else if(nCasterLevel>=10)
        eSummon = EffectSummonCreature("sp_blkdead_1");
    else
        eSummon = EffectSummonCreature("sp_blkdead_n");
    int NewSummon = GetLocalInt(OBJECT_SELF,"SummonCap");
    eSummon = EffectLinkEffects(eVis,eSummon);
    SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, GetSpellTargetLocation());
}

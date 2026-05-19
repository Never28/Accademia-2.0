#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCap=4;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_PALEMASTER, OBJECT_SELF);
    if (nCasterLevel>=13)
        nCap=2;
    int nDuration =40;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sSummon1;
    string sSummon2;
    string sSummon3;
    string sSummon4;
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if(nCasterLevel==30 && nLore>=43)
        eSummon = EffectSummonCreature("sp_paleund_4");
    else if(nCasterLevel>=21 && nLore>=34)
        eSummon = EffectSummonCreature("sp_paleund_3");
    else if(nCasterLevel>=11 && nLore>=24)
        eSummon = EffectSummonCreature("sp_paleund_2");
    else if(nCasterLevel>=10)
        eSummon = EffectSummonCreature("sp_paleund_1");
    else
        eSummon = EffectSummonCreature("sp_paleund_n");
    eSummon = EffectLinkEffects(eVis,eSummon);
    SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, GetSpellTargetLocation());
}

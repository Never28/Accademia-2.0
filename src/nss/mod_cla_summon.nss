void main()
{
    object oPC = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eSummon = EffectSummonCreature(GetLocalString(oPC,"mod_cla_summon"));
    eSummon = EffectLinkEffects(eVis,eSummon);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, GetLocation(oPC));
    DeleteLocalString(oPC,"mod_cla_summon");
}

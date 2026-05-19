void main()
{
    object oPC = OBJECT_SELF;
    int nTyme = GetAbilityModifier(ABILITY_CONSTITUTION,oPC)*2+6;
    effect eVis = EffectVisualEffect(VFX_DUR_AURA_ORANGE);
    effect eAOE = EffectAreaOfEffect(AOE_MOB_FIRE,"","mod_clas_do_en","");
    eAOE = EffectLinkEffects(eVis,eAOE);
    AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,oPC,RoundsToSeconds(nTyme)));
}

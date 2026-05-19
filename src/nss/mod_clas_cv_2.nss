void main()
{
    object oPC = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_DUR_AURA_COLD);
    effect eAOE = EffectAreaOfEffect(AOE_PER_CUSTOM_AOE,"mod_clas_cv_1");
    eAOE = EffectLinkEffects(eAOE,eVis);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, HoursToSeconds(100));
}

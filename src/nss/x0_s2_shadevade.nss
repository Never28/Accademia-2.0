void main()
{
    int nLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
    int nConceal = nLevel * 2;
    int nDuration = 25 + nLevel;
    int nDRAmount = nLevel/3;
    int nAC = nLevel/3;
    effect eConceal = EffectConcealment(nConceal);
    effect eDR = EffectDamageReduction(nDRAmount, DAMAGE_POWER_PLUS_TWENTY);
    effect eAC = EffectACIncrease(nAC);
    effect eDur= EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eLink = EffectLinkEffects(eConceal, eDR);

    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis2);

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);

    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 477, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
}



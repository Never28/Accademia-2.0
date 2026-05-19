#include "X0_I0_SPELLS"
void main()
{
    //Declare major variables
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDaze = EffectDazed();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    int nShad = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC);
    int nUseDaze = nShad/2;
    if(nUseDaze < 1)
        nUseDaze = 1;
    int nSave;
    if(nShad<10)
        nSave = 10 +nShad;
    else if(nShad<20)
        nSave = 15 + nShad;
    else if(nShad<=30)
        nSave = 20 + nShad;
    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
    int nDuration = nShad;
    int nRacial = GetRacialType(oTarget);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 475));
    //check meta magic for extend

    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
       //Make SR check
       if (!MyResistSpell(OBJECT_SELF, oTarget))
       {
            //Make Will Save to negate effect
            if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nSave, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                //Apply VFX Impact and daze effect
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
    if(GetLocalInt(oPC,"nDaze")<nUseDaze)IncrementRemainingFeatUses(oPC,FEAT_SHADOW_DAZE);
    SetLocalInt(oPC,"nDaze",GetLocalInt(oPC,"nDaze")+1);
}



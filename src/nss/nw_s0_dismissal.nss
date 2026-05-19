/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Congedo.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oMaster;
    effect eDeath = EffectDeath(TRUE);
    eDeath = SupernaturalEffect(eDeath);
    effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_BARD){
        int nBard = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
        if(nBard >=21)
            nDC = nDC +5;
        else if(nBard >=15)
            nDC = nDC +3;
        else if(nBard >=10)
            nDC = nDC +2;
        else if(nBard >=5)
            nDC = nDC +1;
    }
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget)){
        oMaster = GetMaster(oTarget);
        if(GetIsObjectValid(oMaster) && spellsIsTarget(oMaster,SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF )){
            if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oMaster) == oTarget ||
               GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oTarget ||
               GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oMaster) == oTarget ){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISMISSAL));
                if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)){
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                     DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

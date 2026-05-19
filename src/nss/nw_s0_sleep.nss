/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Sonno.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_RANGER){
        int nRang = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF);
        if(nRang >=21)
            nDC = nDC +7;
        else if(nRang >=17)
            nDC = nDC +5;
        else if(nRang >=14)
            nDC = nDC +4;
        else if(nRang >=11)
            nDC = nDC +3;
        else if(nRang >=8)
            nDC = nDC +2;
        else
            nDC = nDC +1;
    }
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
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eSleep =  EffectSleep();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
    effect eLink = EffectLinkEffects(eSleep, eMind);
    eLink = EffectLinkEffects(eLink, eDur);
    float fDelay;
    int nMetaMagic = GetMetaMagicFeat();
    int nLevel2 = GetCasterLevel(OBJECT_SELF)/8;
    int nDuration = d4(nLevel2);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDuration = 4*nLevel2;
    if (nMetaMagic == METAMAGIC_EMPOWER)
        nDuration = nDuration + (nDuration/2);
    else if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
            fDelay = GetRandomDelay();
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLEEP));
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);
    }
}

/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Suono Frastornante.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eStun = EffectStunned();
    int nRoll = nCasterLevel;
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eStun, eMind);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eDam;
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
    location lLoc = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eFNF, lLoc);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        while (GetIsObjectValid(oTarget)){
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SOUND_BURST));
                if(!MyResistSpell(OBJECT_SELF, oTarget)){
                    nDamage = d2(nRoll*2);
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        nDamage = nRoll*4;
                    if (nMetaMagic == METAMAGIC_EMPOWER)
                        nDamage = nDamage + (nDamage/2);
                float fDamage = (IntToFloat(nDamage)/100.0)*20.0;
                nDamage = FloatToInt(fDamage);
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
                    DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam,oTarget));
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        }
}


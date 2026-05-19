/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Invisibilita.

#include "x0_i0_spells"

void AuraDiInvisibilita(object oPC,int nTime){
    int AuraDiInvisibilita_CURRENT = GetLocalInt(oPC,"AuraDiInvisibilita_CURRENT");
    if(AuraDiInvisibilita_CURRENT != nTime && AuraDiInvisibilita_CURRENT != 0){
        AuraDiInvisibilita_CURRENT = AuraDiInvisibilita_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_COLD);
        int nLevel = GetCasterLevel(oPC);
        int nBonus = nLevel/4;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
        effect nMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nBonus);
        effect nHide = EffectSkillIncrease(SKILL_HIDE,nBonus);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(nMove, eDur);
        eLink = EffectLinkEffects(eLink, nHide);
        eLink = EffectLinkEffects(eLink, eVis);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) == FALSE){
                SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_INVISIBILITY_SPHERE));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiInvisibilita_CURRENT",AuraDiInvisibilita_CURRENT);
        DelayCommand(6.0,AuraDiInvisibilita(oPC,nTime));
    }
    else
        DeleteLocalInt(oPC,"AuraDiInvisibilita_CURRENT");
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiInvisibilita_CURRENT = GetLocalInt(oPC,"AuraDiInvisibilita_CURRENT");
    int nTime = GetCasterLevel(oPC);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
       nTime = nTime *2;
    if(AuraDiInvisibilita_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_COLD);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        SetLocalInt(oPC,"AuraDiInvisibilita_CURRENT",1);
        AuraDiInvisibilita(oPC,nTime);
    }
}

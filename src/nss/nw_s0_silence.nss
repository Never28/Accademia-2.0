/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Fuoco.

#include "x0_i0_spells"

void AuraDiSilenzio(object oPC,int nTime,int nClass){
    int AuraDiSilenzio_CURRENT = GetLocalInt(oPC,"AuraDiSilenzio_CURRENT");
    if(AuraDiSilenzio_CURRENT != nTime && AuraDiSilenzio_CURRENT != 0){
        AuraDiSilenzio_CURRENT = AuraDiSilenzio_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_SILENCE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        int nDC = GetSpellSaveDC();
        if(nClass == CLASS_TYPE_BARD){
            int nBard = GetLevelByClass(CLASS_TYPE_BARD,oPC);
            if(nBard >=21)
                nDC = nDC +5;
            else if(nBard >=15)
                nDC = nDC +3;
            else if(nBard >=10)
                nDC = nDC +2;
            else if(nBard >=5)
                nDC = nDC +1;
        }
        if(GetHitDice(oPC)==40)
            nDC = nDC +5;
        else if(GetHitDice(oPC)>=31)
            nDC = nDC +3;
        else if(GetHitDice(oPC)>=21)
            nDC = nDC +2;
        else if(GetHitDice(oPC)>=11)
            nDC = nDC +1;
        effect eSilence = EffectSilence();
        effect eVis = EffectVisualEffect(VFX_IMP_HEAD_MIND);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                if(!MyResistSpell(OBJECT_SELF, oTarget)){
                    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_SILENCE));
                    if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, oTarget,6.0);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiSilenzio_CURRENT",AuraDiSilenzio_CURRENT);
        DelayCommand(6.0,AuraDiSilenzio(oPC,nTime,nClass));
    }
    else
        DeleteLocalInt(oPC,"AuraDiSilenzio_CURRENT");
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiSilenzio_CURRENT = GetLocalInt(oPC,"AuraDiSilenzio_CURRENT");
    int nTime = GetCasterLevel(oPC);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
       nTime = nTime *2;
    if(AuraDiSilenzio_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_SILENCE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        SetLocalInt(oPC,"AuraDiSilenzio_CURRENT",1);
        int nClass = GetLastSpellCastClass();
        AuraDiSilenzio(oPC,nTime,nClass);
    }
}

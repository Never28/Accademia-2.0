/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-02-2011
*/

// Aura di Canto Funebre.

#include "x0_i0_spells"

void AuraDiCantoFunebre(object oPC,int nTime){
    int AuraDiCantoFunebre_CURRENT = GetLocalInt(oPC,"AuraDiCantoFunebre_CURRENT");
    if(AuraDiCantoFunebre_CURRENT != nTime && AuraDiCantoFunebre_CURRENT != 0){
        AuraDiCantoFunebre_CURRENT = AuraDiCantoFunebre_CURRENT +1;
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_POISON);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oPC, 6.0);
        int nDC = GetSpellSaveDC()+3;
        if(GetHitDice(oPC)==40)
            nDC = nDC +5;
        effect eStr = EffectAbilityDecrease(ABILITY_DEXTERITY,2);
        effect eDex = EffectAbilityDecrease(ABILITY_STRENGTH,2);
        effect eLink = EffectLinkEffects(eStr,eDex);
        effect eVis = EffectVisualEffect(VFX_FNF_SOUND_BURST);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        while(GetIsObjectValid(oTarget)){
            if(GetIsEnemy(oTarget, oPC) && GetIsDead(oTarget) == FALSE){
                if(!MyResistSpell(OBJECT_SELF, oTarget)){
                    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_DIRGE));
                    if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC)){
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,4.0,GetLocation(oPC));
        }
        SetLocalInt(oPC,"AuraDiCantoFunebre_CURRENT",AuraDiCantoFunebre_CURRENT);
        DelayCommand(6.0,AuraDiCantoFunebre(oPC,nTime));
    }
    else
        DeleteLocalInt(oPC,"AuraDiCantoFunebre_CURRENT");
}

void main()
{
    object oPC = OBJECT_SELF;
    int AuraDiCantoFunebre_CURRENT = GetLocalInt(oPC,"AuraDiCantoFunebre_CURRENT");
    int nTime = GetCasterLevel(oPC);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
       nTime = nTime *2;
    if(AuraDiCantoFunebre_CURRENT == 0){
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_POISON);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, 6.0);
        SetLocalInt(oPC,"AuraDiCantoFunebre_CURRENT",1);
        AuraDiCantoFunebre(oPC,nTime);
    }
}

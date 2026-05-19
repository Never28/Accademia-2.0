/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 28-06-2009
*/

// Funzione per l'implosione.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    effect eDeath = EffectDeath(TRUE);
    eDeath = SupernaturalEffect(eDeath);
    effect eImplode= EffectVisualEffect(VFX_FNF_IMPLOSION);
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImplode, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    if(nCasterLevel>=17){
        while (GetIsObjectValid(oTarget)){
               SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPLOSION));
               fDelay = GetRandomDelay(0.4, 1.2);
               if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay)){
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                    }
               }
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
        }
    }
    else
        SendMessageToPC(OBJECT_SELF,"Per Lanciare questa Magia devi essere di Livello 17");
}


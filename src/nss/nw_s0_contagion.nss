/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Contagio.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nModify = nCasterLvl/10;
    if(nModify == 0)
        nModify = 1;
    nModify = 3*nModify;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    effect eSlow = EffectMovementSpeedDecrease(99);
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eVis3 = EffectVisualEffect(VFX_IMP_SLOW);
    effect eDisease = EffectAbilityDecrease(ABILITY_STRENGTH,nModify);
    effect eDisease2 = EffectAbilityDecrease(ABILITY_DEXTERITY,nModify);
    effect eLink = EffectLinkEffects(eVis,eSlow);
    int nTouch = 1;
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONTAGION));
        if (nTouch > 0){
            if (!MyResistSpell(OBJECT_SELF, oTarget)){
                if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC,SAVING_THROW_TYPE_DISEASE)){
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget,IntToFloat(nModify));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis2, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisease, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisease2, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    DelayCommand(10.0,AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_CONTAGION, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
                }
            }
        }
    }
}


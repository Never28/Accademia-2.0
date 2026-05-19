/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Soffio Freddo Drago.

#include "NW_I0_SPELLS"

void main()
{
    int nFor = GetAbilityModifier(ABILITY_STRENGTH,OBJECT_SELF);
    int nDrak = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,OBJECT_SELF);
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage=0, nDamStrike; // for level drain
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    float fDelay;
    object oTarget;
    effect eVis, eBreath;
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget))
        {
                if (nMutaLv >= 1){
                    if(GetAppearanceType(OBJECT_SELF)==APPEARANCE_TYPE_WYRMLING_WHITE||
                    GetAppearanceType(OBJECT_SELF)==APPEARANCE_TYPE_WYRMLING_SILVER)
                    {
                            nDamage = d2(nDruidLv*3);
                            nDC = 10 + nSag + nMutaLv;
                    }
                    else{
                            nDamage = d8(nDruidLv*2);
                            nDamage = nDamage + d2(nDruidLv);
                            nDC = 10 + nSag + nMutaLv;
                    }
                }
                else{
                    int i;
                    if(nDrak>=1){
                        nDamage = d4(nDrak*2);
                        if(nDrak<10)
                            nDC = 10 +nDrak;
                        else if(nDrak<20)
                            nDC = 15 + nDrak;
                        else if(nDrak<=30)
                            nDC = 20 + nDrak;
                    }
                    else{
                        nDamage = d8(nAge*2);
                        nDamage = nDamage + d2(nAge);
                        nDC = nAge+10;
                    }
                }
            float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
            nDamage = FloatToInt(fDamage);
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Reset the damage to full
            nDamStrike = nDamage;
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DRAGON_BREATH_COLD));
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_COLD, OBJECT_SELF, fDelay))
            {
                nDamStrike = nDamStrike/2;
                if(GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
                {
                    nDamStrike = 0;
                }
            }
            else if(GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
            {
                nDamStrike = nDamStrike/2;
            }
            if (nDamStrike > 0)
            {
                //Set Damage and VFX
                eBreath = EffectDamage(nDamStrike, DAMAGE_TYPE_COLD);
                eVis = EffectVisualEffect(VFX_IMP_FROST_S);
                //Determine effect delay

                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBreath, oTarget));
             }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation(), TRUE);
    }
}



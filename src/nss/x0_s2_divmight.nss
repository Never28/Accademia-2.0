//::///////////////////////////////////////////////
//:: Divine Might
//:: x0_s2_divmight.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Up to (turn undead amount) per day the character may add his Charisma bonus to all
    weapon damage for a number of rounds equal to the Charisma bonus.

    MODIFIED JULY 3 2003
    + Won't stack
    + Set it up properly to give correct + to hit (to a max of +20)

    MODIFIED SEPT 30 2003
    + Made use of new Damage Constants
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13 2002
//:://////////////////////////////////////////////
#include "x0_i0_spells"
#include "x2_inc_itemprop"
void main()
{

   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(40550);
   }
   else
   if(GetHasFeatEffect(413) == FALSE)
   {
        //Declare major variables
        object oTarget = GetSpellTargetObject();
        int nLevel = GetCasterLevel(OBJECT_SELF);
        int nDuration = (GetAbilityModifier(ABILITY_CHARISMA)*2);
        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        int nPala = GetLevelByClass(CLASS_TYPE_PALADIN,OBJECT_SELF);
        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        if (nCharismaBonus>0){
            int nDamage1;
            switch(nCharismaBonus){
                case 1:
                    nDamage1 = DAMAGE_BONUS_1;
                    break;
                case 2:
                    nDamage1 = DAMAGE_BONUS_2;
                    break;
                case 3:
                    nDamage1 = DAMAGE_BONUS_3;
                    break;
                case 4:
                    nDamage1 = DAMAGE_BONUS_4;
                    break;
                case 5:
                    nDamage1 = DAMAGE_BONUS_5;
                    break;
                case 6:
                    nDamage1 = DAMAGE_BONUS_6;
                    break;
                case 7:
                    nDamage1 = DAMAGE_BONUS_7;
                    break;
                case 8:
                    nDamage1 = DAMAGE_BONUS_8;
                    break;
                case 9:
                    nDamage1 = DAMAGE_BONUS_9;
                    break;
                case 10:
                    nDamage1 = DAMAGE_BONUS_10;
                    break;
                case 11:
                    nDamage1 = DAMAGE_BONUS_11;
                    break;
                case 12:
                    nDamage1 = DAMAGE_BONUS_12;
                    break;
                case 13:
                    nDamage1 = DAMAGE_BONUS_13;
                    break;
                case 14:
                    nDamage1 = DAMAGE_BONUS_14;
                    break;
                case 15:
                    nDamage1 = DAMAGE_BONUS_15;
                    break;
                case 16:
                    nDamage1 = DAMAGE_BONUS_16;
                    break;
                case 17:
                    nDamage1 = DAMAGE_BONUS_17;
                    break;
                case 18:
                    nDamage1 = DAMAGE_BONUS_18;
                    break;
                case 19:
                    nDamage1 = DAMAGE_BONUS_19;
                    break;
                case 20:
                    nDamage1 = DAMAGE_BONUS_20;
                    break;
                default:
                    nDamage1 = DAMAGE_BONUS_1;
                    break;
            }

            effect eDamage1 = EffectDamageIncrease(nDamage1,DAMAGE_TYPE_POSITIVE);
            effect eLink = EffectLinkEffects(eDamage1, eDur);
            eLink = SupernaturalEffect(eLink);

            // * Do not allow this to stack
            RemoveEffectsFromSpell(oTarget, GetSpellId());

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIVINE_MIGHT, FALSE));

            //Apply Link and VFX effects to the target
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}




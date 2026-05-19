//:://///////////////////////////////////////////////
//:: X2_S2_MghtyRage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: May 16, 2003
//:://////////////////////////////////////////////
#include "x2_i0_spells"
void main()
{
    if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nCon = 15 + (GetAbilityModifier(ABILITY_CONSTITUTION)*2) ;
        effect eStr = EffectAttackIncrease(6,ATTACK_BONUS_MISC);
        effect eCon = EffectTemporaryHitpoints(60);
        effect eDanno = EffectDamageIncrease(DAMAGE_BONUS_2d12,DAMAGE_TYPE_MAGICAL);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, 4);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);

        effect eLink = EffectLinkEffects(eDanno, eStr);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
        effect eVis2 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        if (nCon > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
             ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCon, OBJECT_SELF, RoundsToSeconds(nCon));
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, RoundsToSeconds(nCon));


            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);
                    // 2003-07-08, Georg: Rage Epic Feat Handling
                CheckAndApplyEpicRageFeats(nCon);
        }
    }
}

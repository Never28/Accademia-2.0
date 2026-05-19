//::///////////////////////////////////////////////
//:: [Control Undead]
//:: [NW_S0_ConUnd.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A single undead with up to 3 HD per caster level
    can be dominated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 2, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk
//:: Last Updated On: April 6, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eControl = EffectCutsceneDominated();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eLink = EffectLinkEffects(eMind, eControl);
    eLink = EffectLinkEffects(eLink, eDur);

    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    int nDuration = nCasterLevel;
    int nHD = nCasterLevel * 2;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nCasterLevel * 2;
    }
    int nAspect = GetAppearanceType(oTarget);
    if ((GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH) && GetHitDice(oTarget) <= nHD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
           //Fire cast spell at event for the specified target
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONTROL_UNDEAD));
           if (!MyResistSpell(OBJECT_SELF, oTarget))
           {
                //Make a Will save
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, 1.0))
                {
                    nDuration= 20;
                    if (nMetaMagic == METAMAGIC_EXTEND)
                        nDuration = nDuration +10;
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                    //Increment HD affected count
                }
            }
        }
    }
}

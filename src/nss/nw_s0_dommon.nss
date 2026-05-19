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


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDiceTarget = GetHitDice(oTarget);
    int nTargetCap;
    if(nDiceTarget>30)
        nTargetCap = 4;
    else if(nDiceTarget>20)
        nTargetCap = 2;
    else
        nTargetCap = 1;
    effect eDom = EffectCutsceneDominated();
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
    eDom = GetScaledEffect(eDom, oTarget);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    //Link domination and persistant VFX
    effect eLink = EffectLinkEffects(eMind, eDom);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 3 + nCasterLevel/2;

    nDuration = GetCasterLevel(OBJECT_SELF);
    int nRacial = GetRacialType(oTarget);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOMINATE_MONSTER, FALSE));
    //Make sure the target is a monster
    if(!GetIsReactionTypeFriendly(oTarget))
    {
          //Make SR Check
          if (!MyResistSpell(OBJECT_SELF, oTarget))
          {
               if(GetIsImmune(oTarget,IMMUNITY_TYPE_MIND_SPELLS,OBJECT_SELF)==FALSE){
                   if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS))
                   {
                        nDuration= 20;
                        if (nMetaMagic == METAMAGIC_EXTEND)
                            nDuration = nDuration +10;
                        //Apply linked effects and VFX Impact
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
           }
     }
}

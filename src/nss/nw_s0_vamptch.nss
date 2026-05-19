//::///////////////////////////////////////////////
//:: Vampiric Touch
//:: NW_S0_VampTch
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    drain 1d6
    HP per 2 caster levels from the target.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

/*
bugfix by Kovi 2002.07.22
- did double damage with maximize
- temporary hp was stacked
2002.08.25
- got temporary hp some immune creatures (Negative Energy Protection), lost
temporary hp against other resistant (SR, Shadow Shield)

Georg 2003-09-11
- Put in melee touch attack check, as the fixed attack bonus is now calculated correctly

*/

#include "x0_I0_SPELLS"
#include "mod_bad_dice"
#include "x2_inc_spellhook"

void main()
{

    //--------------------------------------------------------------------------
    /*  Spellcast Hook Code
       Added 2003-06-20 by Georg
       If you want to make changes to all spells,
       check x2_inc_spellhook.nss to find out more
    */
    //--------------------------------------------------------------------------

    if (!X2PreSpellCastCode())
    {
        return;
    }
    //--------------------------------------------------------------------------
    // End of Spell Cast Hook
    //--------------------------------------------------------------------------


    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();

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
    int nDDice = nCasterLevel /2;
    int nBonus=0;
        int nType = DAMAGE_TYPE_NEGATIVE;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }

    int nDamage = d8(nCasterLevel);
    int nDuration = nCasterLevel/2;

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    nDamage = nNumberRandom(3,nCasterLevel*2);
    float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
    nDamage = FloatToInt(fDamage);
    //--------------------------------------------------------------------------
    //Limit damage to max hp + 10
    //--------------------------------------------------------------------------
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }

    effect eHeal = EffectTemporaryHitpoints(nDamage);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHeal, eDur);

    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        int nAspect = GetAppearanceType(oTarget);
        if(!GetIsReactionTypeFriendly(oTarget) && nAspect != APPEARANCE_TYPE_SKELETON_CHIEFTAIN &&
      nAspect != APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 && nAspect != APPEARANCE_TYPE_MOHRG && nAspect != APPEARANCE_TYPE_MUMMY_GREATER
      && nAspect != APPEARANCE_TYPE_VAMPIRE_MALE && nAspect != APPEARANCE_TYPE_VAMPIRE_FEMALE && nAspect != APPEARANCE_TYPE_LICH
      && nAspect != APPEARANCE_TYPE_MINDFLAYER_ALHOON && nAspect != APPEARANCE_TYPE_DEMI_LICH && nAspect!= APPEARANCE_TYPE_GOLEM_BONE
      && nAspect != APPEARANCE_TYPE_DRACOLICH &&

            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget))
        {


            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, FALSE));
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, TRUE));
            // GZ: * GetSpellCastItem() == OBJECT_INVALID is used to prevent feedback from showing up when used as OnHitCastSpell property
            if (TouchAttackMelee(oTarget,GetSpellCastItem() == OBJECT_INVALID)>0)
            {
                if(MyResistSpell(OBJECT_SELF, oTarget) == 0)
                 {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                    RemoveTempHitPoints();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
                 }
            }
        }
    }
}

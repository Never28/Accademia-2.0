//::///////////////////////////////////////////////
//:: Flame Arrow
//:: NW_S0_FlmArrow
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fires a stream of fiery arrows at the selected
    target that do 4d6 damage per arrow.  1 Arrow
    per 4 levels is created.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 20, 2001
//:: Updated By: Georg Zoeller, Aug 18 2003: Uncapped
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_FIRE;
    int nBonus = 0;
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
            nBonus = 40;
            break;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nDam;
    int nMissiles = (nCasterLvl);
       int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_AZER_FEMALE||Aspect == APPEARANCE_TYPE_AZER_MALE){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nDC;
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        nMissiles = nDruidLv;
        if (nMutaLv >= 1){
            nDC = 10 + nSag + nMutaLv;
        }
    }
    else{
        nDC = GetSpellSaveDC();
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    int nTest;
    effect eMissile, eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    //Limit missiles to five
    if(nMissiles == 0)
    {
        nMissiles = 1;
    }
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_ARROW));
        if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
            nTest = ReflexSave(oTarget,nDC);
            for (nCnt = 1; nCnt <= nMissiles; nCnt++){
                nDam = (Random(3)+1)+(Random(3)+1);

                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDam = 6;
                if (nMetaMagic == METAMAGIC_EMPOWER)
                    nDam = nDam + nDam/2;
                if(nTest == 1){
                    if(GetHasFeat(FEAT_IMPROVED_EVASION))
                        nDam = 0;
                    nDam = nDam /2;
                }
                else if(nTest == 2){
                    nDam = 0;
                }
                eDam = EffectDamage(nDam, nType);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));

            eMissile = EffectVisualEffect(VFX_IMP_MIRV_FLAME);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
        }
        }
    }
}


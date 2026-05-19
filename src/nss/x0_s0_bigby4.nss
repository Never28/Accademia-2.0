//::///////////////////////////////////////////////
//:: Bigby's Clenched Fist
//:: [x0_s0_bigby4]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does an attack EACH ROUND for 1 round/level.
    If the attack hits does
     1d8 +12 points of damage

    Any creature struck must make a FORT save or
    be stunned for one round.

    GZ, Oct 15 2003:
    Changed how this spell works by adding duration
    tracking based on the VFX added to the character.
    Makes the spell dispellable and solves some other
    issues with wrong spell DCs, checks, etc.

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller October 15, 2003

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "x2_i0_spells"


int nSpellID = 462;

void RunHandImpact(object oTarget, object oCaster,int nType,int nBonus)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(nSpellID,oTarget,oCaster))
    {
        return;
    }
    int nCasterRoll;
    int nDC;
    int nCasterLevel =GetCasterLevel(oCaster);
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_DEMI_LICH){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
            int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
            int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
            nDruidLv = nMutaLv + nDruidLv;
            nMutaLv = nDruidLv/2;
            nDC = 10 + nSag + nMutaLv;
            nCasterRoll=d8(nDruidLv*2);
            float fDamage = (IntToFloat(nCasterRoll)/100.0)*10.0;
            nCasterRoll = FloatToInt(fDamage);
    }
    else{
        nDC = GetSpellSaveDC();
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        nCasterRoll = d8(nCasterLevel*2);
        nCasterRoll= nCasterRoll + nBonus;
                float fDamage = (IntToFloat(nCasterRoll)/100.0)*10.0;
                nCasterRoll = FloatToInt(fDamage);

    }

    int nTargetRoll = GetAC(oTarget);
    if (nCasterRoll >= nTargetRoll)
    {
       effect eDam = EffectDamage(nCasterRoll, nType);
       effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);

       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

       if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC))
       {
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oTarget, RoundsToSeconds(1));
       }

      DelayCommand(6.0f,RunHandImpact(oTarget,oCaster,nType,nBonus));

   }
}



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
    // End of Spell Cast Hook

    object oTarget = GetSpellTargetObject();

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one hand, that's enough
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(nSpellID,oTarget) ||  GetHasSpellEffect(463,oTarget)  )
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
    int nSave = SAVING_THROW_TYPE_ALL;
    int nType = DAMAGE_TYPE_BLUDGEONING;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            nBonus = 90;
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
    int nDuration = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    int nCasterLevel = GetCasterLevel(oCaster);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_DEMI_LICH){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,GetAreaOfEffectCreator());
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,GetAreaOfEffectCreator());
        nCasterLevel= (nMutaLv+nDruidLv)/2;
        nDuration = 30;
        if(nDruidLv>=30)
            nDruidLv = 30;
        if(nDruidLv>=nMutaLv)
        nMutaLv = nDruidLv;
        if (nMutaLv >= 1)
            nDC = nSag + nMutaLv;
    }
    else{
        nDC = GetSpellSaveDC();
        if(nCasterLevel>20)
            nDC = nDC +5;
    }
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, TRUE));
        int nResult = MyResistSpell(OBJECT_SELF, oTarget);

        if(nResult  == 0)
        {
            int nCasterModifier = GetCasterAbilityModifier(OBJECT_SELF);
            effect eHand = EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHand, oTarget, RoundsToSeconds(nDuration));

            //----------------------------------------------------------
            // GZ: 2003-Oct-15
            // Save the current save DC on the character because
            // GetSpellSaveDC won't work when delayed
            //----------------------------------------------------------
            SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (nSpellID), nDC);
            object oSelf = OBJECT_SELF;
            RunHandImpact(oTarget,OBJECT_SELF,nType,nBonus);

        }
    }
}


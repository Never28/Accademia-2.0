//::///////////////////////////////////////////////
//:: Black Blade of Disaster
//:: X2_S0_BlckBlde
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a greatsword to battle for the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 26, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller, July 28 - 2003


#include "x2_i0_spells"

//Creates the weapon that the creature will be using.
void spellsCreateItemForSummoned()
{
    //Declare major variables
    int nStat;

    // cast from scroll, we just assume +5 ability modifier
    if (GetSpellCastItem() != OBJECT_INVALID)
    {
        nStat = 5;
    }
     else
    {
        int nClass = GetLastSpellCastClass();
        int nLevel = GetLevelByClass(nClass);

        int nStat;

        int nCha =  GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
        int nInt =  GetAbilityModifier(ABILITY_INTELLIGENCE,OBJECT_SELF);

        if (nClass == CLASS_TYPE_WIZARD)
        {
            nStat = nInt;
        }
        else
        {
            nStat = nCha;
        }

        if (nStat >20)
        {
            nStat =20;
        }

        if (nStat <1)
        {
           nStat = 0;
        }
    }

    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    // Make the blade require concentration
    SetLocalInt(oSummon,"X2_L_CREATURE_NEEDS_CONCENTRATION",TRUE);
    object oWeapon;
    //Create item on the creature, epuip it and add properties.
    oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSummon);
    if (nStat > 0)
    {
        IPSetWeaponEnhancementBonus(oWeapon, nStat);
    }
    SetDroppableFlag(oWeapon, FALSE);
}

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCap=4;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration =40;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    string sSummon1;
    string sSummon2;
    string sSummon3;
    string sSummon4;
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if(nCasterLevel==40 && nLore>=43)
        eSummon = EffectSummonCreature("sp_blackswd_4");
    else if(nCasterLevel>=31 && nLore>=34)
        eSummon = EffectSummonCreature("sp_blackswd_3");
    else if(nCasterLevel>=21 && nLore>=24)
        eSummon = EffectSummonCreature("sp_blackswd_2");
    else if(nCasterLevel>=13)
        eSummon = EffectSummonCreature("sp_blackswd_1");
    else
        eSummon = EffectSummonCreature("sp_blackswd_n");
    eSummon = EffectLinkEffects(eVis,eSummon);
    SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    DelayCommand(1.5, spellsCreateItemForSummoned());
}


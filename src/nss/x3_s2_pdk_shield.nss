//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Heroic Shield
//:: x3_s2_pdk_shield.nss
//:://////////////////////////////////////////////
//:: Applies a temporary AC bonus to one ally
//:://////////////////////////////////////////////
//:: Created By: Stratovarius
//:://////////////////////////////////////////////
/*
    Modified By : gaoneng erick
    Modified On : may 6, 2006
    added custom vfx
*/


void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nPurple = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF) + GetLevelByClass(CLASS_TYPE_FIGHTER, OBJECT_SELF);
    int nBonus = nPurple/4;
    if (nBonus<1)
        nBonus = 1;
    if (GetLocalInt(oPC, "PDKHeroicTracking")){
        FloatingTextStringOnCreature("Puoi utilizzare questa abilita' solo una volta al round per livello", oPC, FALSE);
        return;
    }
    if (oPC == oTarget){
        FloatingTextStringOnCreature("Non puoi potenziare te stesso con questa abilita'", oPC, FALSE);
        return;
    }
    if (!GetIsFriend(oTarget)){
        FloatingTextStringOnCreature("Non puoi potenziare un Nemico con questa abilita'", oPC, FALSE);
        return;
    }
    effect eAC = EffectACIncrease(nBonus);
    effect eVFX = EffectVisualEffect(VFX_IMP_PDK_HEROIC_SHIELD);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, RoundsToSeconds(nPurple*2));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    SetLocalInt(oPC, "PDKHeroicTracking", TRUE);
    DelayCommand(RoundsToSeconds(nPurple), DeleteLocalInt(oPC, "PDKHeroicTracking"));
}

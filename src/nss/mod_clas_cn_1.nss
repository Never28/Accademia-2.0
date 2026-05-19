#include "x2_inc_switches"
void main()
{
    object oPC = OBJECT_SELF;
    int nDamage;
    float fDelay;
    effect eVis;
    effect eVis2;
    effect eHowl;
    int nDC = GetSkillRank(SKILL_HEAL,oPC)/2;
    int nCar;
        int nDuration;
    effect eImpact;
    object oTarget;
    location lTarget = GetLocalLocation(oPC,"CacciatoreNonMorti");
            if(nDC>50)
                nDC = 50;
            eVis = EffectVisualEffect(VFX_IMP_HEALING_M);
            eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
            nCar = GetAbilityModifier(ABILITY_CHARISMA,oPC)*2;
            nDamage = GetSkillRank(SKILL_HEAL,oPC)*5;
            eImpact = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oPC);
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetItemActivatedTargetLocation());
            while(GetIsObjectValid(oTarget)){
                fDelay = GetDistanceBetween(oPC, oTarget)/20;
                if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD){
                    if(oTarget != oPC){
                        if(GetIsFriend(oTarget)){
                            SignalEvent(oTarget, EventSpellCastAt(oPC, SPELLABILITY_PULSE_HOLY, FALSE));
                            eHowl = EffectHeal(nDamage);
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        }
                    }
                }
                else{
                    if(!GetIsReactionTypeFriendly(oTarget)){
                        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_POSITIVE);
                        eHowl = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE) ;
                        if(nDamage > 0){
                            SignalEvent(oTarget, EventSpellCastAt(oPC, SPELLABILITY_PULSE_HOLY));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                        }
                    }
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetItemActivatedTargetLocation());
            }
    DeleteLocalLocation(oPC,"CacciatoreNonMorti");
}

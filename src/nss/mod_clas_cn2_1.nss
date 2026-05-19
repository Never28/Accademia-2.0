#include "x2_inc_switches"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oPC = OBJECT_SELF;
    int nVis;
    effect eVis = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    int nCar;
    int nDC;
        int nRace;
    object oSpellTarget = GetLocalObject(oPC,"CacciatoreNonMorti");
    effect eDeath = EffectDeath(TRUE);
    eDeath = SupernaturalEffect(eDeath);
            nRace = GetRacialType(oSpellTarget);
            nCar = GetAbilityModifier(ABILITY_CHARISMA,oPC)*2;
            if(nRace == RACIAL_TYPE_UNDEAD){
                nDC = GetSkillRank(SKILL_HEAL,oPC)/2;
                if(nDC>50)
                    nDC = 50;
                if(!MySavingThrow(SAVING_THROW_FORT, oSpellTarget, nDC, SAVING_THROW_TYPE_POSITIVE)){
                    DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oSpellTarget));
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oSpellTarget));
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oSpellTarget));
                }
            }
     DeleteLocalObject(oPC,"CacciatoreNonMorti");
}

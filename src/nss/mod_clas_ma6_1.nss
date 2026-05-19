//Sfera Energetica

#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"


void main()
{
    object oPC = OBJECT_SELF;
    location lTarget = GetLocalLocation(oPC,"Arcimago");
    int nDamage1, nDamage2, nDamage3, nDamage4,nDamage5;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eVis3 = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    int nSpellDC = 24;
    if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_EVOCATION,oPC))
        nSpellDC = nSpellDC +6;
    else if(GetHasFeat(FEAT_SPELL_FOCUS_EVOCATION,oPC))
        nSpellDC = nSpellDC + 2;
    else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_EVOCATION,oPC))
        nSpellDC = nSpellDC + 4;
    nSpellDC = nSpellDC + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
    effect eDam1, eDam2, eDam3, eDam4, eKnock;
    eKnock= EffectKnockdown();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    int nTotalDamage;
    while (GetIsObjectValid(oTarget)){
        if(GetIsFriend(oTarget)==FALSE&& GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20 + 1.0f;
            nDamage1 = d10(20);
            nDamage2 = d10(20);
            nDamage3 = d10(20);
            nDamage4 = d10(20);
            if (MySavingThrow(SAVING_THROW_REFLEX,oTarget,nSpellDC,SAVING_THROW_TYPE_SPELL,OBJECT_SELF,fDelay) >0){
                nDamage1 /=2;
                nDamage2 /=2;
                nDamage3 /=2;
                nDamage4 /=2;
            }
            nTotalDamage = nDamage1+nDamage2+nDamage3+nDamage4;
            eDam1 = EffectDamage(nDamage1, DAMAGE_TYPE_MAGICAL);
            eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_POSITIVE);
            eDam3 = EffectDamage(nDamage3, DAMAGE_TYPE_NEGATIVE);
            eDam4 = EffectDamage(nDamage4, DAMAGE_TYPE_DIVINE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam3, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam4, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay+0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            DelayCommand(fDelay+0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
    DeleteLocalLocation(oPC,"Arcimago");

}


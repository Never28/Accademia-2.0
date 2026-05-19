/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Corno di Ferro di Balagarn.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nBonus = nCasterLvl/8;
    nBonus = nBonus*4;
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    float nSize =  RADIUS_SIZE_COLOSSAL;
    effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 20)
        nCasterLvl = 20;
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, RoundsToSeconds(d3()));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && (oTarget != oCaster)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 436));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                effect eTrip = EffectKnockdown();
                if (d20() + GetAbilityScore(oTarget, ABILITY_STRENGTH) <= nBonus + d20() ){
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTrip, oTarget, 6.0));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
                else
                    FloatingTextStrRefOnCreature(2750, OBJECT_SELF, FALSE);
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}








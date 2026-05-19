#include "x2_inc_switches"
#include "x2_i0_spells"

void main()
{
    object oPC   = OBJECT_SELF;
    effect eMind,eDur,eMod,eVis,eVis2;
    int nDC =  (GetAbilityModifier(ABILITY_CHARISMA,oPC)*2)+10;
    int nSong = GetLocalInt(oPC,"canzone");
    switch(nSong){
        case 1:
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
            eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            eVis = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
            eVis2 = EffectVisualEffect(VFX_IMP_SLEEP);
            eMod = EffectTurned();
            break;
        case 2:
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
            eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            eVis2 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
            eVis = EffectVisualEffect(VFX_IMP_CHARM);
            eMod = EffectCharmed();
            break;
        case 3:
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
            eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            eVis2 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
            eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
            eMod = EffectConfused();
            break;
        case 4:
            DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
            eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
            eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            eVis = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
            eVis2 = EffectVisualEffect(VFX_IMP_SLEEP);
            eMod = EffectSleep();
            break;
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
    while(GetIsObjectValid(oTarget)){
        if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget)){
            if(!GetIsReactionTypeFriendly(oTarget,oPC) && oTarget != oPC){
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, oPC, 1.0)){
                    eMod = EffectLinkEffects(eVis, eMod);
                    eMod = EffectLinkEffects(eMod, eDur);
                    eMod = EffectLinkEffects(eMod, eMind);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMod, oTarget,RoundsToSeconds(nDC-10));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
    }
}

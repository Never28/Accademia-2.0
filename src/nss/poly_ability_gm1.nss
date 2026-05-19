#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"


void main()
{
    //Declare major variables
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
    string sAOETag;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDC = 10 + nSag + nMutaLv;
    }
    else{
        nDC = nAge+10;
    }
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    location lTarget =GetSpellTargetLocation();
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_AREA_OF_EFFECT);
    while (GetIsObjectValid(oTarget)){
        if (GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT){
            sAOETag = GetTag(oTarget);
            object oCreator = GetAreaOfEffectCreator(oTarget);
            if ( sAOETag == "VFX_PER_FOGACID"){
                SetLocalInt(oCreator,"AuraDiAcidFog_CURRENT",999999);
                DestroyObject(oTarget);
            }
            else if(sAOETag == "VFX_PER_FOGKILL"){
                SetLocalInt(oCreator,"AuraDiKill_CURRENT",999999);
                DestroyObject(oTarget);
            }
            else if(sAOETag == "VFX_PER_FOGBEWILDERMENT"){
                SetLocalInt(oCreator,"AuraDiPerp_CURRENT",999999);
                DestroyObject(oTarget);
            }
            else if(sAOETag == "VFX_PER_FOGSTINK"){
                SetLocalInt(oCreator,"AuraDiOdore_CURRENT",999999);
                DestroyObject(oTarget);
            }
            else if(sAOETag == "VFX_PER_FOGFIRE"){
                SetLocalInt(oCreator,"AuraDiIncendiary_CURRENT",999999);
                DestroyObject(oTarget);
            }
            else if(sAOETag == "VFX_PER_FOGMIND"){
                SetLocalInt(oCreator,"AuraDiMind_CURRENT",999999);
                DestroyObject(oTarget);
            }
            else if(sAOETag == "VFX_PER_CREEPING_DOOM"){
                SetLocalInt(oCreator,"AuraDiCprDoom_CURRENT",999999);
                DestroyObject(oTarget);
            }
        }
        else if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR){
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR){
                if (GetLocked(oTarget) == FALSE){
                    if (GetIsOpen(oTarget) == FALSE)
                        AssignCommand(oTarget, ActionOpenDoor(oTarget));
                    else
                        AssignCommand(oTarget, ActionCloseDoor(oTarget));
                }
            }
        }
        else if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC)){
                effect eKnockdown = EffectKnockdown();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, RoundsToSeconds(3));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE |OBJECT_TYPE_AREA_OF_EFFECT);
    }
}







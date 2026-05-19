/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Folata di Vento.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    string sAOETag;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nClass = GetLastSpellCastClass();
    int nDC = GetSpellSaveDC();
    nDC =GetSpellSaveDC();
    if(nClass == CLASS_TYPE_BARD){
        int nBard = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
        if(nBard >=21)
            nDC = nDC +5;
        else if(nBard >=15)
            nDC = nDC +3;
        else if(nBard >=10)
            nDC = nDC +2;
        else if(nBard >=5)
            nDC = nDC +1;
    }
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;

    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
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
        else if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR){
                    if (GetLocked(oTarget) == FALSE){
                        if (GetIsOpen(oTarget) == FALSE)
                            AssignCommand(oTarget, ActionOpenDoor(oTarget));
                        else
                            AssignCommand(oTarget, ActionCloseDoor(oTarget));
                    }
                }
                if(!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_FORT, oTarget, nDC)){

                    effect eKnockdown = EffectKnockdown();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, RoundsToSeconds(3));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

                 }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE |OBJECT_TYPE_AREA_OF_EFFECT);
    }
}










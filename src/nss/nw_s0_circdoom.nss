/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Cerchio di Devastazione.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eHeal;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
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
    int nAlign;
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetSpellTargetLocation());
    oTarget =GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget)){
            fDelay = GetRandomDelay();
            nAlign = GetAlignmentGoodEvil(oTarget);
            nDamage = nNumberRandom(5,nCasterLevel*2);
            if (nMetaMagic == METAMAGIC_MAXIMIZE
            || (nAlign == ALIGNMENT_EVIL && GetItemPossessedBy(OBJECT_SELF,"mod_deity_latha")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID)
            || (nAlign == ALIGNMENT_GOOD && GetItemPossessedBy(OBJECT_SELF,"mod_deity_talos")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID))
                nDamage =10* nCasterLevel;
            if (nMetaMagic == METAMAGIC_EMPOWER)
                nDamage = nDamage + (nDamage/2);
            float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
            nDamage = FloatToInt(fDamage);
            if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DOOM, FALSE));
                eHeal = EffectHeal(nDamage);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
            else{
               if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DOOM));
                    if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                        if (MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF, fDelay))
                            nDamage = nDamage/2;
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
        }
}


/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Luce/Incandescente.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oCaster);
    int nDamage;
    int nMax;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eRay = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
        if(!GetIsReactionTypeFriendly(oTarget)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SEARING_LIGHT));
            eRay = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
            if (!MyResistSpell(oCaster, oTarget)){
                nCasterLevel = nCasterLevel/2;
                int nAspect = GetAppearanceType(oTarget);
                if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH){
                    if(nCasterLevel == 0)
                        nCasterLevel = 1;
                    nDamage = d4(nCasterLevel*2);
                    nMax = 8;
                }
                else if (GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT){
                    if(nCasterLevel == 0)
                        nCasterLevel = 1;
                    nDamage = nCasterLevel;
                    nMax = 1;
                }
                else{
                    if(nCasterLevel == 0)
                        nCasterLevel = 1;
                    nDamage = d2(nCasterLevel*2);
                    nMax = 4;
                }
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDamage = nMax * nCasterLevel;
                if (nMetaMagic == METAMAGIC_EMPOWER)
                    nDamage = nDamage + (nDamage/2);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}


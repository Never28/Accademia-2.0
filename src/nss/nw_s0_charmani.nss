/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Charme Mostri o Animali.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_CHARM);
    effect eCharm = EffectCharmed();
    eCharm = GetScaledEffect(eCharm, oTarget);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eCharm);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    int nDuration = 2  + nCasterLevel/3;
    nDuration = GetScaledDuration(nDuration, oTarget);
    int nRacial = GetRacialType(oTarget);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHARM_PERSON_OR_ANIMAL, FALSE));
        if (!MyResistSpell(OBJECT_SELF, oTarget)){
            if  ((nRacial == RACIAL_TYPE_DWARF) ||
                (nRacial == RACIAL_TYPE_ANIMAL) ||
                (nRacial == RACIAL_TYPE_ELF) ||
                (nRacial == RACIAL_TYPE_GNOME) ||
                (nRacial == RACIAL_TYPE_HUMANOID_GOBLINOID) ||
                (nRacial == RACIAL_TYPE_HALFLING) ||
                (nRacial == RACIAL_TYPE_HUMAN) ||
                (nRacial == RACIAL_TYPE_HALFELF) ||
                (nRacial == RACIAL_TYPE_HALFORC) ||
                (nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS) ||
                (nRacial == RACIAL_TYPE_HUMANOID_ORC) ||
                (nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN)){
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS)){
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
    }
}

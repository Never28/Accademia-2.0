/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Aura Magica Contro il Bene.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    RemoveSpellEffects(GetSpellId(),OBJECT_SELF,GetSpellTargetObject());
    doAura(ALIGNMENT_GOOD, VFX_DUR_PROTECTION_EVIL_MAJOR, VFX_DUR_PROTECTION_EVIL_MAJOR, DAMAGE_TYPE_NEGATIVE);
}


/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Aura Magica Contro il Male.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    RemoveSpellEffects(GetSpellId(),OBJECT_SELF,GetSpellTargetObject());
    doAura(ALIGNMENT_EVIL, VFX_DUR_PROTECTION_GOOD_MAJOR, VFX_DUR_PROTECTION_GOOD_MAJOR, DAMAGE_TYPE_DIVINE);
}


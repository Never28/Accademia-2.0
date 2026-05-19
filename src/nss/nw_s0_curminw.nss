/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Cura Ferite Minore.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nSpellID = GetSpellId();
    object oCaster = GetLastSpellCaster();
    spellsCure(0,0, 0, 0, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID);
}

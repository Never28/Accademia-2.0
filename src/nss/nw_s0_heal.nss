/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Guarigione.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nSpellID = GetSpellId();
    object oCaster = GetLastSpellCaster();
    int nLevel = GetCasterLevel(oCaster);
    int nRoll = d20(nLevel/2);
    if(nRoll==0)
        nRoll=d20(1);
    spellsCure(5,0, 0, 0, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_X, nSpellID);
}

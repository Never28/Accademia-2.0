/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Cura Ferite Moderate.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nSpellID = GetSpellId();
    object oCaster = GetLastSpellCaster();
    int nLevel = GetCasterLevel(oCaster);
    int nRoll = nLevel/2;
    if(nRoll==0)
        nRoll=1;
        spellsCure(2,0, 0, 0, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_M, nSpellID);
}

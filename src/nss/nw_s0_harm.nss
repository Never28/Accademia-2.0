/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Ferire.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nSpellID = GetSpellId();
    object oCaster = GetLastSpellCaster();
    int nLevel = GetCasterLevel(oCaster);
    int nRoll = nLevel;
    spellsInflictTouchAttack(5,nRoll+(6*nLevel), 0, (14)*nLevel, 246, VFX_IMP_HEALING_G, nSpellID);
}


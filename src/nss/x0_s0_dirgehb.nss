/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Canto Funebre Heat.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    object oTarget;
    oTarget = GetFirstInPersistentObject(OBJECT_SELF);
    while(GetIsObjectValid(oTarget)){
        DoDirgeEffect(oTarget);
        oTarget = GetNextInPersistentObject(OBJECT_SELF);
    }
}



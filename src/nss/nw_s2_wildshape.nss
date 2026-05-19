/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 28-06-2009
*/

// Messaggio per la trasformazione in animali.


#include "x2_inc_itemprop"

void main()
{
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    SendMessageToPC(oTarget,"Per trasformarti utilizza la Chat digitando il nome delle Creatura Desiderata (Lista sul Libro di Aluando");
}

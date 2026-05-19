/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Il classico Chiudi Porte dopo 60 Secondi

#include "x2_inc_switches"

void main()
{
    // La Porta da Chiudersi.
    object oDoor = OBJECT_SELF;
    // Dopo 60 Secondi Chiudi la porta.
    DelayCommand(60.0,ActionCloseDoor(oDoor));
}

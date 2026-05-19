/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

#include "x2_inc_switches"

void main()
{
            object oPC   = GetLastUsedBy();
            AssignCommand(oPC,ActionStartConversation(oPC,"mod_bas_sca",TRUE));
}


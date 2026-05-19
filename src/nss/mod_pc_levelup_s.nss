/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-07-2009
*/

// Funzione per il level up teleport del Sapiente Elementale.

void main()
{
    object oPC = OBJECT_SELF;
    object oWay = GetWaypointByTag("mod_elemental_t1");
    location oLocation = GetLocation(oWay);
    AssignCommand(oPC,JumpToLocation(oLocation));
}

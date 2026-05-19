/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-07-2009
*/

// Funzione per il level up teleport del druido.

void main()
{
    object oPC = OBJECT_SELF;
    object oWay = GetWaypointByTag("mod_deity_druid_t1");
    location oLocation = GetLocation(oWay);
    AssignCommand(oPC,JumpToLocation(oLocation));
}

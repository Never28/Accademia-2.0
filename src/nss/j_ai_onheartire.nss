void main()
{
   string mex="Ora che ho la tua anima, non ho piu bisogno di perdere tempo in questo luogo...forse un giorno ci rivedremo.";
   int HPattuali;
   int HPmassimi;
   int x;
   effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
   location lTarget = GetLocation(GetWaypointByTag("tappaportalesottosuolo"));
   ExecuteScript("j_ai_onheartbeat",OBJECT_SELF);
   HPattuali = GetCurrentHitPoints(OBJECT_SELF);
   HPmassimi = GetMaxHitPoints(OBJECT_SELF);
   x=(30*HPmassimi)/100;
   if(HPattuali<=x)
   {
     FloatingTextStringOnCreature(mex, GetLastDamager(OBJECT_SELF));
     ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF);
     DelayCommand(1.0, DestroyObject(OBJECT_SELF));
     CreateObject(OBJECT_TYPE_PLACEABLE, "portale_sottosuo", lTarget);
   }
}

void main()
{
   object oNoticed = GetLastPerceived();
   if(GetIsObjectValid(oNoticed)&&GetIsInCombat(OBJECT_SELF)==FALSE)
   {
      if (GetLastPerceptionSeen() && GetIsEnemy(oNoticed))
      {
         ClearAllActions();
         ActionAttack(oNoticed);
      }
   }
}

#include "NW_I0_GENERIC"

void main()
{
   object oMinion = OBJECT_SELF;
   object oTargetTower = GetNearestObject(OBJECT_TYPE_PLACEABLE,oMinion);
   object oTargetMinion = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oMinion);
   float fTowerMinion = GetDistanceBetween(oTargetTower,oMinion);
   float fMinionMinion = GetDistanceBetween(oTargetMinion,oMinion);
   if(oTargetTower!=OBJECT_INVALID||oTargetMinion!=OBJECT_INVALID){
        if(fTowerMinion<fMinionMinion && fTowerMinion<20.0){
            if(GetSubString(GetTag(oTargetTower),6,4)=="good"&&GetSubString(GetTag(oMinion),10,3)=="mal"){
                ClearAllActions();
                ActionAttack(oTargetTower);
            }
            else if(GetSubString(GetTag(oTargetTower),6,4)=="evil"&&GetSubString(GetTag(oMinion),10,3)=="buo"){
                ClearAllActions();
                ActionAttack(oTargetTower);
            }
        }
        else if(fTowerMinion>=fMinionMinion && fMinionMinion<20.0){
            ClearAllActions();
            ActionAttack(oTargetMinion);
        }
        else{
            AssignCommand(oMinion,WalkWayPoints(FALSE,0.0));
        }
   }
   else{
        AssignCommand(oMinion,WalkWayPoints(FALSE, 0.0));
   }
}

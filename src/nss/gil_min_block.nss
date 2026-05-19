#include "NW_I0_GENERIC"

void main()
{
    object oMinion = OBJECT_SELF;
    if(GetIsInCombat(oMinion)==FALSE){
        string sTag = GetTag(oMinion);
        AssignCommand(oMinion,WalkWayPoints(FALSE, 0.0));
    }
}

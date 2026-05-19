#include "mod_bas_que_func"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nQuestT = LetturaQuest(38,oPC);
    if(nQuestT>=3&&GetIsDM(oPC)==FALSE){
        return TRUE;
    }
    return FALSE;
}

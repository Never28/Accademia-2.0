#include "mod_bas_que_func"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nQuest1 = LetturaQuest(1,oPC);
    int nQuest2 = LetturaQuest(26,oPC);
    int nQuest3 = LetturaQuest(29,oPC);
    int nQuestT = LetturaQuest(38,oPC);
    int nCont = 0;
    if(nQuest1==3)
        nCont++;
    if(nQuest2==2)
        nCont++;
    if(nQuest3==2)
        nCont++;
    if(nQuestT==2&&nCont<2&&GetIsDM(oPC)==FALSE){
        return TRUE;
    }
    return FALSE;
}

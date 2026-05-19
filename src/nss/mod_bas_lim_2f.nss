#include "mod_bas_que_func"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nQuest1 = LetturaQuest(5,oPC);
    int nQuest2 = LetturaQuest(6,oPC);
    int nQuest3 = LetturaQuest(28,oPC);
    int nQuest4 = LetturaQuest(7,oPC);
    int nQuest5 = LetturaQuest(4,oPC);
    int nQuest6 = LetturaQuest(3,oPC);
    int nQuest7 = LetturaQuest(2,oPC);
    int nQuestT = LetturaQuest(38,oPC);
    int nCont = 0;
    if(nQuest1==3)
        nCont++;
    if(nQuest2==3)
        nCont++;
    if(nQuest3==3)
        nCont++;
    if(nQuest4==3)
        nCont++;
    if(nQuest5==3)
        nCont++;
    if(nQuest6==3)
        nCont++;
    if(nQuest7==3)
        nCont++;
    if(nQuestT==3&&nCont<4&&GetIsDM(oPC)==FALSE){
        return TRUE;
    }
    return FALSE;
}

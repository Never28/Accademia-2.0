#include "mod_bas_que_func"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    if(nQuest == 3||nQuest == 5)
        return TRUE;
    return FALSE;
}

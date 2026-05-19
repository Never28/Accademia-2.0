#include "mod_bas_que_func"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    if(nQuest == 1||nQuest == 2||nQuest == 3)
        return TRUE;
    return FALSE;
}

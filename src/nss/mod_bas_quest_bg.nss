#include "mod_bas_que_func"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    int nControllNave = GetLocalInt(OBJECT_SELF,"quest_nave_dag");
    if(nQuest != 0&&nControllNave==0)
        return TRUE;
    return FALSE;
}

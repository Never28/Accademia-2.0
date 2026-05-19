#include "mod_bas_que_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    if(nQuest == 0){
        AddJournalQuestEntry("quest_"+sQuest,1,oPC,FALSE);
        ScritturaQuest("1",StringToInt(sQuest),oPC);
    }
}

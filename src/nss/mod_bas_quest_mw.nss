#include "mod_bas_que_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    if(nQuest==4){
        if(sQuest=="8"){
            GiveXPToCreature(oPC,5000);
            GiveGoldToCreature(oPC,5000);
        }
        if(sQuest=="12"){
            GiveXPToCreature(oPC,10000);
            GiveGoldToCreature(oPC,10000);
        }
        AddJournalQuestEntry("quest_"+sQuest,5,oPC,FALSE);
        ScritturaQuest("5",StringToInt(sQuest),oPC);
    }
}

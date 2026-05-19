#include "mod_bas_que_func"

void main()
{
    object oCorpse = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    string sQuest = GetLocalString(oCorpse,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    SpeakString("Questo corpo morto sembra stato dilaniato da creature differenti dai formian. La curiosita' ti spinge a controllare cosa ci sia ancora piu' in profondita'");
    if(nQuest == 0){
        AddJournalQuestEntry("quest_"+sQuest,1,oPC,FALSE);
        ScritturaQuest("1",StringToInt(sQuest),oPC);
    }
}

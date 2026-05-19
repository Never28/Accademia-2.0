#include "mod_bas_que_func"

void main()
{
    object oPC = GetPCSpeaker();
    DelayCommand(0.0,ScritturaQuest("3",38,oPC));
    DelayCommand(1.0,IncollaStringa(oPC, GetLocalString(oPC,"quest")));
    AddJournalQuestEntry("quest_38",3,oPC,FALSE);
    if(GetItemPossessedBy(oPC,"mod_bas_tele_t")!=OBJECT_INVALID){
        string sDesc = GetDescription(oPC);
        string sTrama1 = " \nPortando a termine gli incarichi dei cittadini bisognosi, hai diffuso il tuo nome tra le mura della biblioteca. Le guardie ti hanno consegnato un lasciapassare come riconoscimento al tuo valore che ti permetterà di inoltrarti nella foresta senza problemi.";
        sDesc = sDesc + sTrama1;
        SetDescription(oPC,sDesc);
    }
}

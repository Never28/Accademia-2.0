#include "mod_bas_que_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nQuest = LetturaQuest(StringToInt(sQuest),oPC);
    if(nQuest==1){
        if(StringToInt(sQuest) == 36){
            GiveXPToCreature(oPC,18000);
            GiveGoldToCreature(oPC,18000);
        }
        AddJournalQuestEntry("quest_"+sQuest,2,oPC,FALSE);
        ScritturaQuest("2",StringToInt(sQuest),oPC);
    }
    if(nQuest==2){
        if(StringToInt(sQuest) == 1){
            GiveXPToCreature(oPC,500);
            GiveGoldToCreature(oPC,500);
        }
        else if(StringToInt(sQuest) == 2){
            GiveXPToCreature(oPC,3000);
            GiveGoldToCreature(oPC,3000);
        }
        else if(StringToInt(sQuest) == 3){
            GiveXPToCreature(oPC,3500);
            GiveGoldToCreature(oPC,3500);
        }
        else if(StringToInt(sQuest) == 4){
            GiveXPToCreature(oPC,4000);
            GiveGoldToCreature(oPC,4000);
        }
        else if(StringToInt(sQuest) == 5){
            GiveXPToCreature(oPC,3000);
            GiveGoldToCreature(oPC,3000);
        }
        else if(StringToInt(sQuest) == 6){
            GiveXPToCreature(oPC,4000);
            GiveGoldToCreature(oPC,4000);
        }
        else if(StringToInt(sQuest) == 7){
            GiveXPToCreature(oPC,5000);
            GiveGoldToCreature(oPC,5000);
        }
        else if(StringToInt(sQuest) == 9){
            GiveXPToCreature(oPC,5000);
            GiveGoldToCreature(oPC,5000);
        }
        else if(StringToInt(sQuest) == 11){
            GiveXPToCreature(oPC,7000);
            GiveGoldToCreature(oPC,7000);
        }
        else if(StringToInt(sQuest) == 14){
            GiveXPToCreature(oPC,7000);
            GiveGoldToCreature(oPC,7000);
        }
        else if(StringToInt(sQuest) == 15){
            GiveXPToCreature(oPC,8000);
            GiveGoldToCreature(oPC,8000);
        }
        else if(StringToInt(sQuest) == 16){
            GiveXPToCreature(oPC,12000);
            GiveGoldToCreature(oPC,12000);
        }
        else if(StringToInt(sQuest) == 17){
            GiveXPToCreature(oPC,12000);
            GiveGoldToCreature(oPC,12000);
        }
        else if(StringToInt(sQuest) == 18){
            GiveXPToCreature(oPC,8000);
            GiveGoldToCreature(oPC,8000);
        }
        else if(StringToInt(sQuest) == 19){
            GiveXPToCreature(oPC,13000);
            GiveGoldToCreature(oPC,13000);
        }
        else if(StringToInt(sQuest) == 20){
            GiveXPToCreature(oPC,13000);
            GiveGoldToCreature(oPC,13000);
        }
        else if(StringToInt(sQuest) == 21){
            GiveXPToCreature(oPC,14000);
            GiveGoldToCreature(oPC,14000);
        }
        else if(StringToInt(sQuest) == 22){
            GiveXPToCreature(oPC,14000);
            GiveGoldToCreature(oPC,14000);
        }
        else if(StringToInt(sQuest) == 24){
            GiveXPToCreature(oPC,14000);
            GiveGoldToCreature(oPC,14000);
        }
        else if(StringToInt(sQuest) == 25){
            GiveXPToCreature(oPC,15000);
            GiveGoldToCreature(oPC,15000);
        }
        else if(StringToInt(sQuest) == 28){
            GiveXPToCreature(oPC,6000);
            GiveGoldToCreature(oPC,6000);
        }
        else if(StringToInt(sQuest) == 30){
            GiveXPToCreature(oPC,200);
            GiveGoldToCreature(oPC,200);
        }
        else if(StringToInt(sQuest) == 31){
            GiveXPToCreature(oPC,15000);
            GiveGoldToCreature(oPC,15000);
        }
        else if(StringToInt(sQuest) == 32){
            GiveXPToCreature(oPC,16000);
            GiveGoldToCreature(oPC,16000);
        }
        else if(StringToInt(sQuest) == 33){
            GiveXPToCreature(oPC,16000);
            GiveGoldToCreature(oPC,16000);
        }
        else if(StringToInt(sQuest) == 34){
            GiveXPToCreature(oPC,16000);
            GiveGoldToCreature(oPC,16000);
        }
        else if(StringToInt(sQuest) == 35){
            GiveXPToCreature(oPC,18000);
            GiveGoldToCreature(oPC,18000);
        }
        else if(StringToInt(sQuest) == 37){
            GiveXPToCreature(oPC,18000);
            GiveGoldToCreature(oPC,18000);
        }
        else if(StringToInt(sQuest) == 39){
            GiveXPToCreature(oPC,20000);
            GiveGoldToCreature(oPC,20000);
        }
        else if(StringToInt(sQuest) == 40){
            GiveXPToCreature(oPC,22000);
            GiveGoldToCreature(oPC,22000);
        }
        else if(StringToInt(sQuest) == 41){
            GiveXPToCreature(oPC,25000);
            GiveGoldToCreature(oPC,25000);
        }
        else if(StringToInt(sQuest) == 42){
            GiveXPToCreature(oPC,25000);
            GiveGoldToCreature(oPC,25000);
        }
        AddJournalQuestEntry("quest_"+sQuest,3,oPC,FALSE);
        ScritturaQuest("3",StringToInt(sQuest),oPC);
    }
    else if(nQuest==16){
        if(StringToInt(sQuest) == 13){
            GiveXPToCreature(oPC,10000);
            GiveGoldToCreature(oPC,10000);
        }
        AddJournalQuestEntry("quest_"+sQuest,17,oPC,FALSE);
        ScritturaQuest("h",StringToInt(sQuest),oPC);
    }
    IncollaStringa(oPC, GetLocalString(oPC,"quest"));
}

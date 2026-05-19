#include "mod_clas_poly_sp"
#include "mod_clas_poly_co"

void main()
{
    object oPC = GetPCChatSpeaker();
    if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID||GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID){
        int iPattern = GetChatCreature(oPC,GetPCChatMessage());
        if(iPattern == 0)
            return;
        ChatTrasformation(oPC,iPattern);
    }
}

/*
  CREATO DA:      Tinco
  DATA CREAZIONE: 24-06-2009
*/

// La funzione per fare partire il mercante di accessori

#include "nw_i0_plot"

void main()
{
    object oFab = GetObjectByTag("neg_ber_fab");
    int nOccupato = GetLocalInt(oFab,"occupato");
    if(nOccupato==0){
        object oStore = GetNearestObjectByTag("ber_fab");
        if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
            gplotAppraiseOpenStore(oStore, GetPCSpeaker());
        else
            ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
    else{
        AssignCommand(oFab,ActionSpeakString("Sono un'attimo occupato a forgiare un oggetto, passa fra un'attimo"));
    }
}

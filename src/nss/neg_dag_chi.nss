/*
  CREATO DA:      Tinco
  DATA CREAZIONE: 24-06-2009
*/

// La funzione per fare partire il mercante di accessori

#include "nw_i0_plot"

void main()
{
    object oStore = GetNearestObjectByTag("dag_chi");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}

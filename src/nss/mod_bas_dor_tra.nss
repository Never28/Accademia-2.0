#include "nw_i0_2q4luskan"

void SafeDestroyObject(object oObject)
{
     SetIsDestroyable(TRUE);
        if(GetPlotFlag(oObject))
            DelayCommand(0.0,SetPlotFlag(oObject, FALSE));
        if(GetImmortal(oObject))
            DelayCommand(0.0,SetImmortal(oObject, FALSE));
        if(!GetDroppableFlag(oObject))
            DelayCommand(0.0,SetDroppableFlag(oObject, TRUE));
        DestroyObject(oObject);
}

void main()
{
    DelayCommand(60.0,ActionCloseDoor(OBJECT_SELF));
    object oDoor = OBJECT_SELF;
    string sDoor = GetTag(oDoor);
    string sMob;
    int nMorte = GetLocalInt(GetModule(),"skalmad");
    // CONTROLLO SE IL MOSTRO E' MORTO E SE QUINDI LE PORTE SI APRONO
    if(nMorte == 1){
        int nPortaAttiva = GetLocalInt(OBJECT_SELF,"skalmad_door");
        // MA IL RESPAWN E' SINGOLO
        if(nPortaAttiva == 0){
            int nRandom = Random(8);
            // RANDOMIZZO IL MOSTRO DA SPAWNARE
            if(nRandom == 0)
                sMob = "set_19_bam";
            else if(nRandom == 1)
                sMob = "set_51_tfa";
            else if(nRandom == 2)
                sMob = "set_51_tfc";
            else if(nRandom == 3)
                sMob = "set_51_tfm";
            else if(nRandom == 4)
                sMob = "set_45_lma";
            else if(nRandom == 5)
                sMob = "set_45_lmf";
            else if(nRandom == 6)
                sMob = "set_45_lml";
            else if(nRandom == 7)
                sMob = "set_36_fla";
            // MI ASSICURO CHE LA PROSSIMA VOLTA LA PORTA NON SPAWNERA MOB
            SetLocalInt(OBJECT_SELF,"skalmad_door",1);
            int nPortaMostro = GetLocalInt(OBJECT_SELF,"skalmad_quest");
            if(nPortaMostro == 1){
                string sTappa = GetStringRight(sDoor,1);
                sTappa = "sk_t" + sTappa;
                object oTappa = GetWaypointByTag(sTappa);
                location lTappa = GetLocation(oTappa);
                object oQuest = CreateObject(OBJECT_TYPE_CREATURE,"png_quest_36",lTappa);
                DelayCommand(900.0,SafeDestroyObject(oQuest));
            }
            else{
                string sTappa = GetStringRight(sDoor,1);
                sTappa = "sk_t" + sTappa;
                object oTappa = GetWaypointByTag(sTappa);
                location lTappa = GetLocation(oTappa);
                object oMob1 = CreateObject(OBJECT_TYPE_CREATURE,sMob,lTappa);
                string sName = GetName(oMob1);
                SetName(oMob1,sName+" Prigioniero");
                object oMob2 = CreateObject(OBJECT_TYPE_CREATURE,sMob,lTappa);
                sName = GetName(oMob2);
                SetName(oMob2,sName+" Prigioniero");
                object oMob3 = CreateObject(OBJECT_TYPE_CREATURE,sMob,lTappa);
                sName = GetName(oMob3);
                SetName(oMob3,sName+" Prigioniero");
                DelayCommand(900.0,SafeDestroyObject(oMob1));
                DelayCommand(900.0,SafeDestroyObject(oMob2));
                DelayCommand(900.0,SafeDestroyObject(oMob3));
            }
        }
    }
}

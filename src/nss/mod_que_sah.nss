#include "nw_i0_2q4luskan"

void SafeDestroyObject(object oObject){
    SetIsDestroyable(TRUE);
    DestroyObject(oObject);
}

void main()
{
    object oStatue = OBJECT_SELF;
    string sStatue = GetTag(oStatue);
    object oStatueD;
    object oTap;
    location lTap;
    if(sStatue == "sek_1"){
        oTap = GetObjectByTag("sek_t1");
        lTap = GetLocation(oTap);
        oStatueD = CreateObject(OBJECT_TYPE_PLACEABLE,"sek_d1",lTap);
        ExecuteScript("mod_que_sah_2",oStatueD);
    }
    else if(sStatue == "sek_2"){
        oTap = GetObjectByTag("sek_t2");
        lTap = GetLocation(oTap);
        oStatueD = CreateObject(OBJECT_TYPE_PLACEABLE,"sek_d2",lTap);
        ExecuteScript("mod_que_sah_2",oStatueD);
    }
    else if(sStatue == "sek_3"){
        oTap = GetObjectByTag("sek_t3");
        lTap = GetLocation(oTap);
        oStatueD = CreateObject(OBJECT_TYPE_PLACEABLE,"sek_d3",lTap);
        ExecuteScript("mod_que_sah_2",oStatueD);
    }
    else if(sStatue == "sek_4"){
        oTap = GetObjectByTag("sek_t4");
        lTap = GetLocation(oTap);
        oStatueD = CreateObject(OBJECT_TYPE_PLACEABLE,"sek_d4",lTap);
        ExecuteScript("mod_que_sah_2",oStatueD);
    }
}

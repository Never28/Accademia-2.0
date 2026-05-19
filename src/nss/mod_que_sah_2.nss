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
    if(sStatue == "sek_d1"){
        oTap = GetObjectByTag("sek_t1");
        lTap = GetLocation(oTap);
        DelayCommand(179.0,ExecuteScript("mod_que_sah_3",oTap));
        DelayCommand(180.0,SafeDestroyObject(OBJECT_SELF));
    }
    else if(sStatue == "sek_d2"){
        oTap = GetObjectByTag("sek_t2");
        lTap = GetLocation(oTap);
        DelayCommand(179.0,ExecuteScript("mod_que_sah_3",oTap));
        DelayCommand(180.0,SafeDestroyObject(OBJECT_SELF));
    }
    else if(sStatue == "sek_d3"){
        oTap = GetObjectByTag("sek_t3");
        lTap = GetLocation(oTap);
        DelayCommand(179.0,ExecuteScript("mod_que_sah_3",oTap));
        DelayCommand(180.0,SafeDestroyObject(OBJECT_SELF));
    }
    else if(sStatue == "sek_d4"){
        oTap = GetObjectByTag("sek_t4");
        lTap = GetLocation(oTap);
        DelayCommand(179.0,ExecuteScript("mod_que_sah_3",oTap));
        DelayCommand(180.0,SafeDestroyObject(OBJECT_SELF));
    }
}

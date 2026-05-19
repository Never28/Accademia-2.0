void main()
{
    object oTap = OBJECT_SELF;
    string sTap = GetTag(oTap);
    location lTap;
    object oStatueD;
    if(sTap == "sek_t1"){
        lTap = GetLocation(oTap);
        CreateObject(OBJECT_TYPE_PLACEABLE,"sek_1",lTap);
    }
    else if(sTap == "sek_t2"){
        lTap = GetLocation(oTap);
        CreateObject(OBJECT_TYPE_PLACEABLE,"sek_2",lTap);
    }
    else if(sTap == "sek_t3"){
        lTap = GetLocation(oTap);
        CreateObject(OBJECT_TYPE_PLACEABLE,"sek_3",lTap);
    }
    else if(sTap == "sek_t4"){
        lTap = GetLocation(oTap);
        CreateObject(OBJECT_TYPE_PLACEABLE,"sek_4",lTap);
    }
}

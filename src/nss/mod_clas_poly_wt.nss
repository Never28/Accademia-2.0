void main()
{
    object oPC = OBJECT_SELF;
    int nTimer = GetLocalInt(oPC,"metamorfosi");
    if(nTimer == 60){
        ExecuteScript("mod_clas_poly_wi",oPC);
        SetLocalInt(oPC,"metamorfosispec",0);
        SetLocalInt(oPC,"metamorfosi",0);
    }
    else
        DelayCommand(1.0,ExecuteScript("mod_clas_poly_wt",oPC));
    nTimer = nTimer + 1;
    SetLocalInt(oPC,"metamorfosi",nTimer);
}

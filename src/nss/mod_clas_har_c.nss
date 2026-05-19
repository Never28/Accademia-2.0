void main()
{
    float fCurrent = GetFacing(OBJECT_SELF);
    object oPC = GetLocalObject(OBJECT_SELF,"Tirante");
    if(GetLastUsedBy()==oPC){
        AssignCommand(OBJECT_SELF,ClearAllActions());
        AssignCommand(oPC,ClearAllActions());
        if (fCurrent > 360.0)
            fCurrent = 720 - fCurrent;
        float fNew = fCurrent - 15.0;
        if (fNew <= 0.0)
            fNew = fNew + 360.0;
        AssignCommand(OBJECT_SELF,SetFacing(fNew));
    }
}

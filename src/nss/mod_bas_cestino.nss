void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

void main()
{
    object oCestino = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(oCestino);
    while(oItem!=OBJECT_INVALID){
        SafeDestroyObject(oItem,0.0);
        oItem = GetNextItemInInventory(oCestino);
    }
}

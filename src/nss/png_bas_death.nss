void main()
{
    object oMe = OBJECT_SELF;
    SetPlotFlag(oMe, TRUE);
    SetIsDestroyable(FALSE, TRUE, TRUE);
    DelayCommand(180.0,ExecuteScript("png_bas_res",OBJECT_SELF));
}

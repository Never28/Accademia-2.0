
void main()
{
    object oObject = OBJECT_SELF;
    if(GetIsDead(oObject)==TRUE){
        effect eRaise = EffectResurrection();
        effect eHeal = EffectHeal(GetMaxHitPoints());
        effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
        string sTag = GetTag(OBJECT_SELF);
        if(sTag == "png_xzar")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t1"))));
        else if(sTag == "png_imoen")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t2"))));
        else if(sTag == "png_montaron")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t3"))));
        else if(sTag == "png_xan")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t1"))));
        else if(sTag == "png_minsc")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t2"))));
        else if(sTag == "png_branwen")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t3"))));
        else if(sTag == "png_kagain")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t1"))));
        else if(sTag == "png_sharteel")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t2"))));
        else if(sTag == "png_garrick")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t3"))));
        else if(sTag == "png_jaheira")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t1"))));
        else if(sTag == "png_khalid")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t2"))));
        else if(sTag == "png_kivan")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t3"))));
        else if(sTag == "png_alora")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t1"))));
        else if(sTag == "png_quayle")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t2"))));
        else if(sTag == "png_ajantis")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t3"))));
        else if(sTag == "png_eldoth")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t1"))));
        else if(sTag == "png_tiax")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t2"))));
        else if(sTag == "png_yeslick")
            DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t3"))));
        SetPlotFlag(OBJECT_SELF, FALSE);
        SetIsDestroyable(TRUE, TRUE, TRUE);
        AssignCommand(OBJECT_SELF,ClearAllActions());
        ForceRest(oObject);
    }
}

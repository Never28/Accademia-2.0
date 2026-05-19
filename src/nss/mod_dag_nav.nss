#include "nw_i0_2q4luskan"

void SafeDestroyObject(object oObject){
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject))
        DelayCommand(0.0,SetPlotFlag(oObject, FALSE));
    if(GetImmortal(oObject))
        DelayCommand(0.0,SetImmortal(oObject, FALSE));
    if(!GetDroppableFlag(oObject))
        DelayCommand(0.0,SetDroppableFlag(oObject, TRUE));
    DestroyObject(oObject);
}

void SpawnaMostri(){
    object oWay1 = GetWaypointByTag("WP_barca_sah_t1");
    object oWay2 = GetWaypointByTag("WP_barca_sah_t2");
    object oWay3 = GetWaypointByTag("WP_barca_sah_t3");
    CreateObjectVoid(OBJECT_TYPE_CREATURE, "set_48_ssp", GetLocation(oWay1),TRUE);
    CreateObjectVoid(OBJECT_TYPE_CREATURE, "set_48_ssp", GetLocation(oWay2),TRUE);
    CreateObjectVoid(OBJECT_TYPE_CREATURE, "set_48_ssp", GetLocation(oWay3),TRUE);
}

void Distruzione(object oArea){
    object oTarget = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oTarget)==TRUE){
        if(GetIsPC(oTarget) == FALSE && GetObjectType(oTarget)== OBJECT_TYPE_CREATURE){
            SafeDestroyObject(oTarget);
        }
        oTarget = GetNextObjectInArea(oArea);
    }
}

void SafeTeleport(object oPC){
    int nLife = GetCurrentHitPoints(oPC);
    if(nLife<=0){
        effect eRaise = EffectResurrection();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oPC);
        SafeDestroyObject(GetItemPossessedBy(oPC,"mod_bas_dead"));
        effect eDam = EffectDamage(1000,DAMAGE_TYPE_MAGICAL);
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oPC));
    }
}

void main()
{
    object oBarile = GetObjectByTag("nav_dag_sal");
    object oTarget = GetWaypointByTag("WP_isola_sah_barca");
    object oTarget2 = GetWaypointByTag("WP_sah_sba_t1");
    SetLocalInt(OBJECT_SELF,"quest_nave_dag",1);
    DelayCommand(15.0,SpawnaMostri());
    DelayCommand(45.0,SpawnaMostri());
    DelayCommand(75.0,SpawnaMostri());
    DelayCommand(105.0,SpawnaMostri());
    DelayCommand(135.0,SpawnaMostri());
    DelayCommand(165.0,SpawnaMostri());
    DelayCommand(179.0,Distruzione(GetArea(oTarget)));
    DelayCommand(180.0,SetLocalInt(OBJECT_SELF,"quest_nave_dag",0));
    object oTele = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oBarile));
    while(GetIsObjectValid(oTele)==TRUE){
        if(GetIsPC(oTele)==TRUE){
            AssignCommand(oTele, ClearAllActions(TRUE));
            DelayCommand(3.0, AssignCommand(oTele, ActionJumpToObject(oTarget)));
            DelayCommand(179.5, SafeTeleport(oTarget));
            DelayCommand(180.0, AssignCommand(oTele, ActionJumpToObject(oTarget2)));
        }
        oTele = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oBarile));
    }
}

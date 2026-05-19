#include "nw_i0_2q4luskan"

float TIME = 1.5;

void SpawnOrda(string sMob,location lSpawn){
    DelayCommand(0.0,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME*2,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME*3,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME*4,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME*5,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME*6,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
    DelayCommand(TIME*7,CreateObjectVoid(OBJECT_TYPE_CREATURE,sMob,lSpawn));
}

void CreaTurret(string sTurret,location lTurret){
    object oTurret = CreateObject(OBJECT_TYPE_PLACEABLE,sTurret,lTurret);
    ExecuteScript("gil_tvt_turret",oTurret);
}

void main()
{
    int i,j;
    string sTurret = "tower_good_";
    string sLocation = "tower_buoni_";
    location lTurret;
    for(i=1;i<=3;i++){
            for(j=1;j<=3;j++){
                lTurret = GetLocation(GetWaypointByTag(sLocation+IntToString(i)+IntToString(j)));
                CreaTurret(sTurret+IntToString(i)+IntToString(j),lTurret);
            }
    }
    sTurret = "tower_evil_";
    sLocation = "tower_cattivi_";
    for(i=1;i<=3;i++){
            for(j=1;j<=3;j++){
                lTurret = GetLocation(GetWaypointByTag(sLocation+IntToString(i)+IntToString(j)));
                CreaTurret(sTurret+IntToString(i)+IntToString(j),lTurret);
            }
    }
    string sWay = "spawn_tvt_b1";
    string sMob = "min_gilda_buo_1";
    object oWaySpawn = GetWaypointByTag(sWay);
    location lSpawn = GetLocation(oWaySpawn);
    SpawnOrda(sMob,lSpawn);
    sWay = "spawn_tvt_b2";
    sMob = "min_gilda_buo_2";
    oWaySpawn = GetWaypointByTag(sWay);
    lSpawn = GetLocation(oWaySpawn);
    SpawnOrda(sMob,lSpawn);
    sWay = "spawn_tvt_b3";
    sMob = "min_gilda_buo_3";
    oWaySpawn = GetWaypointByTag(sWay);
    lSpawn = GetLocation(oWaySpawn);
    SpawnOrda(sMob,lSpawn);
    sWay = "spawn_tvt_m1";
    sMob = "min_gilda_mal_1";
    oWaySpawn = GetWaypointByTag(sWay);
    lSpawn = GetLocation(oWaySpawn);
    SpawnOrda(sMob,lSpawn);
    sWay = "spawn_tvt_m2";
    sMob = "min_gilda_mal_2";
    oWaySpawn = GetWaypointByTag(sWay);
    lSpawn = GetLocation(oWaySpawn);
    SpawnOrda(sMob,lSpawn);
    sWay = "spawn_tvt_m3";
    sMob = "min_gilda_mal_3";
    oWaySpawn = GetWaypointByTag(sWay);
    lSpawn = GetLocation(oWaySpawn);
    SpawnOrda(sMob,lSpawn);
    object oTarget = GetFirstObjectInArea(GetArea(OBJECT_SELF));
    while(GetIsObjectValid(oTarget)==TRUE){
        if(GetObjectType(oTarget)==OBJECT_TYPE_PLACEABLE){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,90),oTarget);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,90),oTarget);
        }
        oTarget = GetNextObjectInArea(GetArea(OBJECT_SELF));
    }
}

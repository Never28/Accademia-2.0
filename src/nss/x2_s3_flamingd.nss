//::///////////////////////////////////////////////
//:: OnHit Firedamage
//:: x2_s3_flamgind
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

   OnHit Castspell Fire Damage property for the
   flaming weapon spell (x2_s0_flmeweap).

   We need to use this property because we can not
   add random elemental damage to a weapon in any
   other way and implementation should be as close
   as possible to the book.


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-17
//:://////////////////////////////////////////////

void main()
{
  // Get Caster Level
  int nLevel = GetCasterLevel(OBJECT_SELF);
  // Assume minimum caster level if variable is not found
  if (nLevel== 0)
  {
     nLevel =1;
  }
    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_FIRE;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            nBonus = 5;
            break;
    }
  int nDmg = nLevel/4;
  nDmg = nDmg + nBonus;
  effect eDmg = EffectDamage(nDmg,nType);
  effect eVis;
  if (nDmg<10) // if we are doing below 10 point of damage, use small flame
  {
    eVis =EffectVisualEffect(VFX_IMP_FLAME_S);
  }
  else
  {
     eVis =EffectVisualEffect(VFX_IMP_FLAME_M);
  }
  eDmg = EffectLinkEffects (eVis, eDmg);
  object oTarget = GetSpellTargetObject();

  if (GetIsObjectValid(oTarget))
  {
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget);
  }
}

/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando viene caricato il modulo.

#include "x2_inc_switches"
#include "x2_inc_toollib"
#include "x2_inc_restsys"
void main()
{
    object oModule = GetModule();
    ExecuteScript("mod_pc_heat_new",oModule);
    int nGildaBuoni1 = GetCampaignInt("accademia_gilde","gb1");
    int nGildaBuoni2 = GetCampaignInt("accademia_gilde","gb2");
    int nGildaBuoni3 = GetCampaignInt("accademia_gilde","gb3");
    int nGildaBuoni4 = GetCampaignInt("accademia_gilde","gb4");
    int nGildaBuoni5 = GetCampaignInt("accademia_gilde","gb5");
    int nGildaBuoni6 = GetCampaignInt("accademia_gilde","gb6");
    int nGildaBuoni7 = GetCampaignInt("accademia_gilde","gb7");
    int nGildaBuoni8 = GetCampaignInt("accademia_gilde","gb8");
    int nGildaBuoni9 = GetCampaignInt("accademia_gilde","gb9");
    int nGildaCattivi1 = GetCampaignInt("accademia_gilde","gm1");
    int nGildaCattivi2 = GetCampaignInt("accademia_gilde","gm2");
    int nGildaCattivi3 = GetCampaignInt("accademia_gilde","gm3");
    int nGildaCattivi4 = GetCampaignInt("accademia_gilde","gm4");
    int nGildaCattivi5 = GetCampaignInt("accademia_gilde","gm5");
    int nGildaCattivi6 = GetCampaignInt("accademia_gilde","gm6");
    int nGildaCattivi7 = GetCampaignInt("accademia_gilde","gm7");
    int nGildaCattivi8 = GetCampaignInt("accademia_gilde","gm8");
    int nGildaCattivi9 = GetCampaignInt("accademia_gilde","gm9");
    SetLocalInt(oModule,"gb1",nGildaBuoni1);
    SetLocalInt(oModule,"gb2",nGildaBuoni2);
    SetLocalInt(oModule,"gb3",nGildaBuoni3);
    SetLocalInt(oModule,"gb4",nGildaBuoni4);
    SetLocalInt(oModule,"gb5",nGildaBuoni5);
    SetLocalInt(oModule,"gb6",nGildaBuoni6);
    SetLocalInt(oModule,"gb7",nGildaBuoni7);
    SetLocalInt(oModule,"gb8",nGildaBuoni8);
    SetLocalInt(oModule,"gb9",nGildaBuoni9);
    SetLocalInt(oModule,"gm1",nGildaCattivi1);
    SetLocalInt(oModule,"gm2",nGildaCattivi2);
    SetLocalInt(oModule,"gm3",nGildaCattivi3);
    SetLocalInt(oModule,"gm4",nGildaCattivi4);
    SetLocalInt(oModule,"gm5",nGildaCattivi5);
    SetLocalInt(oModule,"gm6",nGildaCattivi6);
    SetLocalInt(oModule,"gm7",nGildaCattivi7);
    SetLocalInt(oModule,"gm8",nGildaCattivi8);
    SetLocalInt(oModule,"gm9",nGildaCattivi9);
    TLChangeAreaGroundTiles(GetObjectByTag("dun_gro_sah_3"),X2_TL_GROUNDTILE_WATER,13,10,2.0);
    TLChangeAreaGroundTiles(GetObjectByTag("ext_che_acq"),X2_TL_GROUNDTILE_WATER,20,20,9.0);
    TLChangeAreaGroundTiles(GetObjectByTag("dun_che_bib"),X2_TL_GROUNDTILE_WATER,8,8,2.0);
    TLChangeAreaGroundTiles(GetObjectByTag("dun_che_ing"),X2_TL_GROUNDTILE_WATER,8,8,2.0);
    TLChangeAreaGroundTiles(GetObjectByTag("dun_che_tro"),X2_TL_GROUNDTILE_WATER,3,8,2.0);
   if (GetGameDifficulty() ==  GAME_DIFFICULTY_CORE_RULES || GetGameDifficulty() ==  GAME_DIFFICULTY_DIFFICULT)
   {

   }
   SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

   if (GetModuleSwitchValue (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
   {
   }

   if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM) == TRUE)
   {
       WMBuild2DACache();
   }

}

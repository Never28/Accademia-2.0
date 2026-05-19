void Scalcare(object oPC,string sTagTarget,string sResTarget,int i){
    int nRandom = Random(10)+1;
    //5% di probabilita' ognuno per fare piu di 5% basta fare uguali alcuni drop
    switch(nRandom){
        //CASI AL 10%
        case 1:
            if(sTagTarget=="set_1"){
                if(sResTarget=="set_1_gal")
                    CreateItemOnObject("craft_1_gal",oPC);
                else if(sResTarget=="set_1_muc")
                    CreateItemOnObject("craft_1_muc",oPC);
                else if(sResTarget=="set_1_rat")
                    CreateItemOnObject("craft_1_rat",oPC);
                else if(sResTarget=="set_1_mum")
                    CreateItemOnObject("craft_1_mum",oPC);
                else if(sResTarget=="set_1_omb")
                    CreateItemOnObject("craft_1_omb",oPC);
                else if(sResTarget=="set_1_all")
                    CreateItemOnObject("craft_1_all",oPC);
                else if(sResTarget=="set_1_sch"||sResTarget=="set_1_gho")
                    CreateItemOnObject("craft_1_sch",oPC);
                else if(sResTarget=="set_1_zom"||sResTarget=="set_1_zog"||sResTarget=="set_1_zot")
                    CreateItemOnObject("craft_1_zom",oPC);
                else if(sResTarget=="set_1_rat_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_1_rat_bos1",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_2"){
                if(sResTarget=="set_2_lcs")
                    CreateItemOnObject("craft_2_lsc",oPC);
                else if(sResTarget=="set_2_lra"||sResTarget=="set_2_lca")
                    CreateItemOnObject("craft_2_lra",oPC);
                else if(sResTarget=="set_2_lba"||sResTarget=="set_2_lgu")
                    CreateItemOnObject("craft_2_lba",oPC);
                else if(sResTarget=="set_2_mum"||sResTarget=="set_2_mor"||sResTarget=="set_2_mha")
                    CreateItemOnObject("craft_2_mum",oPC);
            }
            else if(sTagTarget=="set_3"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_3_bos1",oPC);
                    }
            }
            else if(sTagTarget=="set_4"){
                if(sResTarget=="set_4_mb1"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_4_mb11",oPC);
                        }
                }
                else if(sResTarget=="set_4_mb2"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_4_mb21",oPC);
                        }
                }
                else if(sResTarget=="set_4_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_4_bos1",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_5"){
                if(sResTarget=="set_5_orf"||sResTarget=="set_5_orm")
                    CreateItemOnObject("craft_5_orf",oPC);
                else if(sResTarget=="set_5_orv"||sResTarget=="set_5_ors")
                    CreateItemOnObject("craft_5_orv",oPC);
                else if(sResTarget=="set_5_goa"||sResTarget=="set_5_gos")
                    CreateItemOnObject("craft_5_goa",oPC);
                else if(sResTarget=="set_5_goc"||sResTarget=="set_5_gow")
                    CreateItemOnObject("craft_5_goc",oPC);
            }
            else if(sTagTarget=="set_6"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_6_bos1",oPC);
                    }
            }
            else if(sTagTarget=="set_7"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_7_bos1",oPC);
                    }
            }
            else if(sTagTarget=="set_8"){
                if(sResTarget=="set_8_scg")
                    CreateItemOnObject("craft_8_scg",oPC);
                else if(sResTarget=="set_8_scc")
                    CreateItemOnObject("craft_8_scc",oPC);
                else if(sResTarget=="set_8_scw")
                    CreateItemOnObject("craft_8_scw",oPC);
                else if(sResTarget=="set_8_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_8_bos1",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_9"){
                if(sResTarget=="set_9_tas"||sResTarget=="set_9_pum"||sResTarget=="set_9_lup"||sResTarget=="set_9_fal")
                    CreateItemOnObject("craft_9_pum",oPC);
                else if(sResTarget=="set_9_bug"||sResTarget=="set_9_bua")
                    CreateItemOnObject("craft_9_bua",oPC);
                else if(sResTarget=="set_9_bue"||sResTarget=="set_9_buh")
                    CreateItemOnObject("craft_9_bue",oPC);
                else if(sResTarget=="set_9_bus")
                    CreateItemOnObject("craft_9_bus",oPC);
            }
            else if(sTagTarget=="set_10"){
                if(sResTarget=="set_10_mb1"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_10_mb11",oPC);
                        }
                }
                else if(sResTarget=="set_10_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_10_bos1",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_11"){
                if(sResTarget=="set_11_gob")
                    CreateItemOnObject("craft_11_gob_1",oPC);
                else if(sResTarget=="set_11_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_11_bos1",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_12"){
                if(sResTarget=="set_12_orc")
                    CreateItemOnObject("craft_12_orc_1",oPC);
                else if(sResTarget=="set_12_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_12_bos1",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_13"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_13_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_14"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_14_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_15"){
                if(sResTarget=="set_15_hal"||sResTarget=="set_15_hum")
                    CreateItemOnObject("craft_15_hal",oPC);
                if(sResTarget=="set_15_mez")
                    CreateItemOnObject("craft_15_mez",oPC);
                if(sResTarget=="set_15_elf")
                    CreateItemOnObject("craft_15_elf",oPC);
                if(sResTarget=="set_15_hgu"||sResTarget=="set_15_hsc")
                    CreateItemOnObject("craft_15_hsc",oPC);
                if(sResTarget=="set_15_hba")
                    CreateItemOnObject("craft_15_hba",oPC);
            }
            else if(sTagTarget=="set_16"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_16_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_17"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_17_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_18"){
                if(sResTarget=="set_18_eco"||sResTarget=="set_18_ece")
                    CreateItemOnObject("craft_18_ece",oPC);
                if(sResTarget=="set_18_gco"||sResTarget=="set_18_gce")
                    CreateItemOnObject("craft_18_gce",oPC);
            }
            else if(sTagTarget=="set_19"){
                if(sResTarget=="set_19_luf"||sResTarget=="set_19_luv")
                    CreateItemOnObject("craft_19_luv",oPC);
                if(sResTarget=="set_19_bas"||sResTarget=="set_19_bam")
                    CreateItemOnObject("craft_19_bam",oPC);
                else if(sResTarget=="set_19_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_19_bos1",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_20"){
               if(sResTarget=="set_20_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_20_bos1",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_22"){
               if(sResTarget=="set_22_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_22_bos1",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_23"){
               if(sResTarget=="set_23_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_23_bos1",oPC);
                    }
                }
                else if(sResTarget=="set_23_mb1"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_23_mb11",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_24"){
                if(sResTarget=="set_24_mis"||sResTarget=="set_24_min")
                    CreateItemOnObject("craft_24_mis",oPC);
                else if(sResTarget=="set_24_mic")
                    CreateItemOnObject("craft_24_mic",oPC);
                else if(sResTarget=="set_24_mid")
                    CreateItemOnObject("craft_24_mid",oPC);
                else if(sResTarget=="set_24_rag"||sResTarget=="set_24_raf")
                    CreateItemOnObject("craft_24_rag",oPC);
                else if(sResTarget=="set_24_rac"||sResTarget=="set_24_rav")
                    CreateItemOnObject("craft_24_rac",oPC);
            }
            else if(sTagTarget=="set_25"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_25_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_26"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_26_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_27"){
                if(sResTarget=="set_27_oba"||sResTarget=="set_27_och"||sResTarget=="set_27_ost")
                    CreateItemOnObject("craft_27_oba",oPC);
                else if(sResTarget=="set_27_gsf")
                    CreateItemOnObject("craft_27_gsf",oPC);
                else if(sResTarget=="set_27_ggu"||sResTarget=="set_27_gcc")
                    CreateItemOnObject("craft_27_ggu",oPC);
                else if(sResTarget=="set_27_gar"||sResTarget=="set_27_gga")
                    CreateItemOnObject("craft_27_gar",oPC);
            }
            else if(sTagTarget=="set_28"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_28_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_29"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_29_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_30"){
                if(sResTarget=="set_30_lun"||sResTarget=="set_30_lnf")
                    CreateItemOnObject("craft_30_lnf",oPC);
                else if(sResTarget=="set_30_orp"||sResTarget=="set_30_opa")
                    CreateItemOnObject("craft_30_opa",oPC);
                else if(sResTarget=="set_30_tgu"||sResTarget=="set_30_tca")
                    CreateItemOnObject("craft_30_tca",oPC);
                else if(sResTarget=="set_30_tma")
                    CreateItemOnObject("craft_30_tma",oPC);
                else if(sResTarget=="set_30_tga"||sResTarget=="set_30_tco")
                    CreateItemOnObject("craft_30_tco",oPC);
            }
            else if(sTagTarget=="set_31"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_31_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_32"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_32_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_33"){
                if(sResTarget=="set_33_cob"||sResTarget=="set_33_cco")
                    CreateItemOnObject("craft_33_cco",oPC);
                else if(sResTarget=="set_33_chc")
                    CreateItemOnObject("craft_33_chc",oPC);
                else if(sResTarget=="set_33_tco")
                    CreateItemOnObject("craft_33_tco",oPC);
                else if(sResTarget=="set_33_dta"||sResTarget=="set_33_dte")
                    CreateItemOnObject("craft_33_dte",oPC);
                else if(sResTarget=="set_33_dan")
                    CreateItemOnObject("craft_33_dan",oPC);
            }
            else if(sTagTarget=="set_34"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_34_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_35"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_35_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_36"){
                if(sResTarget=="set_36_fla"||sResTarget=="set_36_fgu")
                    CreateItemOnObject("craft_36_fgu",oPC);
                else if(sResTarget=="set_36_fca")
                    CreateItemOnObject("craft_36_fca",oPC);
                else if(sResTarget=="set_36_sgu"||sResTarget=="set_36_sba")
                    CreateItemOnObject("craft_36_sba",oPC);
                else if(sResTarget=="set_36_sst")
                    CreateItemOnObject("craft_36_sst",oPC);
            }
            else if(sTagTarget=="set_37"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_37_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_38"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_38_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_39"){
                if(sResTarget=="set_39_vcu"||sResTarget=="set_39_vgi")
                    CreateItemOnObject("craft_39_vgi",oPC);
                else if(sResTarget=="set_39_tro"||sResTarget=="set_39_tca")
                    CreateItemOnObject("craft_39_tca",oPC);
                else if(sResTarget=="set_39_tch")
                    CreateItemOnObject("craft_39_tch",oPC);
                else if(sResTarget=="set_39_vad")
                    CreateItemOnObject("craft_39_vad",oPC);
            }
            else if(sTagTarget=="set_40"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_40_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_41"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_41_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_42"){
                if(sResTarget=="set_42_gep"||sResTarget=="set_42_gem"||sResTarget=="set_42_geg")
                    CreateItemOnObject("craft_42_gem",oPC);
                else if(sResTarget=="set_42_dop"||sResTarget=="set_42_din")
                    CreateItemOnObject("craft_42_din",oPC);
                else if(sResTarget=="set_42_dze")
                    CreateItemOnObject("craft_42_dze",oPC);
                else if(sResTarget=="set_42_cub")
                    CreateItemOnObject("craft_42_cub",oPC);
            }
            else if(sTagTarget=="set_43"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_43_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_44"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_44_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_45"){
                if(sResTarget=="set_45_lml"||sResTarget=="set_45_lma")
                    CreateItemOnObject("craft_45_lma",oPC);
                else if(sResTarget=="set_45_ysa"||sResTarget=="set_45_yme")
                    CreateItemOnObject("craft_45_yme",oPC);
                else if(sResTarget=="set_45_yab")
                    CreateItemOnObject("craft_45_yab",oPC);
                else if(sResTarget=="set_45_lmf")
                    CreateItemOnObject("craft_45_lmf",oPC);
            }
            else if(sTagTarget=="set_46"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_46_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_47"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_47_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_48"){
                if(sResTarget=="set_48_sah"||sResTarget=="set_48_sac")
                    CreateItemOnObject("craft_48_sac",oPC);
                else if(sResTarget=="set_48_sas")
                    CreateItemOnObject("craft_48_sas",oPC);
            }
            else if(sTagTarget=="set_49"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_49_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_50"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_50_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_51"){
                if(sResTarget=="set_51_tvd"||sResTarget=="set_51_tvi")
                    CreateItemOnObject("craft_51_tvd",oPC);
                else if(sResTarget=="set_51_tvs")
                    CreateItemOnObject("craft_51_tvs",oPC);
                if(sResTarget=="set_51_tfa"||sResTarget=="set_51_tfc")
                    CreateItemOnObject("craft_51_tfc",oPC);
                else if(sResTarget=="set_51_tfm")
                    CreateItemOnObject("craft_51_tfm",oPC);
            }
            else if(sTagTarget=="set_61"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_61_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_63"){
                if(sResTarget=="set_63_bna"||sResTarget=="set_63_bum")
                    CreateItemOnObject("craft_63_bum",oPC);
                else if(sResTarget=="set_63_bgn"||sResTarget=="set_63_bel")
                    CreateItemOnObject("craft_63_bgn",oPC);
            }
            else if(sTagTarget=="set_73"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_73_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_75"){
                if(sResTarget=="set_75_eac"||sResTarget=="set_75_eam")
                    CreateItemOnObject("craft_75_eam",oPC);
                else if(sResTarget=="set_75_eaa")
                    CreateItemOnObject("craft_75_eaa",oPC);
            }
            else if(sTagTarget=="set_76"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_76_bos1",oPC);
                }
            }
            else if(sTagTarget=="set_78"){
                if(sResTarget=="set_78_ggm"||sResTarget=="set_78_ggf")
                    CreateItemOnObject("craft_78_ggf",oPC);
                else if(sResTarget=="set_78_ggs")
                    CreateItemOnObject("craft_78_ggs",oPC);
            }
            break;



        //CASI AL 40%
        case 2: case 3: case 4: case 5:
            if(sTagTarget=="set_1"){
                if(sResTarget=="set_1_gal"||sResTarget=="set_1_muc"||sResTarget=="set_1_rat")
                    CreateItemOnObject("craft_1_g_m",oPC);
                else if(sResTarget=="set_1_mum"||sResTarget=="set_1_zog"||sResTarget=="set_1_zot"
                        ||sResTarget=="set_1_zom"||sResTarget=="set_1_sch"||sResTarget=="set_1_all"
                        ||sResTarget=="set_1_omb"||sResTarget=="set_1_gho")
                    CreateItemOnObject("craft_1_nmo",oPC);
                else if(sResTarget=="set_1_rat_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_1_rat_bos2",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_2"){
                if(sResTarget=="set_2_lsc"||sResTarget=="set_2_lra"||sResTarget=="set_2_lba"||sResTarget=="set_2_lgu"||sResTarget=="set_2_lca")
                    CreateItemOnObject("craft_2_lgu",oPC);
                else if(sResTarget=="set_2_mum"||sResTarget=="set_2_mor"||sResTarget=="set_2_mha")
                    CreateItemOnObject("craft_2_mor",oPC);
            }
            else if(sTagTarget=="set_3"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_3_bos2",oPC);
                    }
            }
            else if(sTagTarget=="set_4"){
                if(sResTarget=="set_4_mb1"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_4_mb12",oPC);
                        }
                }
                else if(sResTarget=="set_4_mb2"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_4_mb22",oPC);
                        }
                }
                else if(sResTarget=="set_4_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_4_bos2",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_5"){
                if(sResTarget=="set_5_orf"||sResTarget=="set_5_orm"||sResTarget=="set_5_orv"||sResTarget=="set_5_ors")
                    CreateItemOnObject("craft_5_orm",oPC);
                else if(sResTarget=="set_5_goa"||sResTarget=="set_5_gos"||sResTarget=="set_5_goc"||sResTarget=="set_5_gow")
                    CreateItemOnObject("craft_5_gos",oPC);
            }
            else if(sTagTarget=="set_6"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_6_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_7"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_7_bos2",oPC);
                }
            }
            if(sTagTarget=="set_8"){
                if(sResTarget=="set_8_scg"||sResTarget=="set_8_scc"||sResTarget=="set_8_scw")
                    CreateItemOnObject("craft_1_sch",oPC);
                else if(sResTarget=="set_8_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_8_bos2",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_9"){
                if(sResTarget=="set_9_tas"||sResTarget=="set_9_pum"||sResTarget=="set_9_lup"||sResTarget=="set_9_fal")
                    CreateItemOnObject("craft_9_tas",oPC);
                else if(sResTarget=="set_9_bug"||sResTarget=="set_9_bua"||sResTarget=="set_9_bue"||sResTarget=="set_9_buh"||sResTarget=="set_9_bus")
                    CreateItemOnObject("craft_9_bug",oPC);
            }
            else if(sTagTarget=="set_10"){
                if(sResTarget=="set_10_mb1"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_10_mb12",oPC);
                        }
                }
                else if(sResTarget=="set_10_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_10_bos2",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_11"){
                if(sResTarget=="set_11_gob")
                    CreateItemOnObject("craft_11_gob",oPC);
                else if(sResTarget=="set_11_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_11_bos2",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_12"){
                if(sResTarget=="set_12_orc")
                    CreateItemOnObject("craft_12_orc",oPC);
                else if(sResTarget=="set_12_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_12_bos2",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_13"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_13_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_14"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_14_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_15"){
                if(sResTarget=="set_15_hal"||sResTarget=="set_15_hum"||sResTarget=="set_15_elf"||sResTarget=="set_15_mez")
                    CreateItemOnObject("craft_15_hum",oPC);
                if(sResTarget=="set_15_hgu"||sResTarget=="set_15_hsc"||sResTarget=="set_15_hba")
                    CreateItemOnObject("craft_15_hgu",oPC);
            }
            else if(sTagTarget=="set_16"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_16_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_17"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_17_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_18"){
                if(sResTarget=="set_18_eco"||sResTarget=="set_18_ece")
                    CreateItemOnObject("craft_18_eco",oPC);
                if(sResTarget=="set_18_gco"||sResTarget=="set_18_gce")
                    CreateItemOnObject("craft_18_gco",oPC);
            }
            else if(sTagTarget=="set_19"){
                if(sResTarget=="set_19_luf"||sResTarget=="set_19_luv")
                    CreateItemOnObject("craft_19_luf",oPC);
                if(sResTarget=="set_19_bas"||sResTarget=="set_19_bam")
                    CreateItemOnObject("craft_19_bas",oPC);
                else if(sResTarget=="set_19_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_19_bos2",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_20"){
               if(sResTarget=="set_20_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_20_bos2",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_22"){
               if(sResTarget=="set_22_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_22_bos2",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_23"){
               if(sResTarget=="set_23_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_23_bos2",oPC);
                    }
                }
                else if(sResTarget=="set_23_mb1"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_23_mb12",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_24"){
                if(sResTarget=="set_24_min"||sResTarget=="set_24_mid"||sResTarget=="set_24_mis"||sResTarget=="set_24_mic")
                    CreateItemOnObject("craft_24_min",oPC);
                else if(sResTarget=="set_24_rag"||sResTarget=="set_24_raf"||sResTarget=="set_24_rac"||sResTarget=="set_24_rav")
                    CreateItemOnObject("craft_24_raf",oPC);
            }
            else if(sTagTarget=="set_25"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_25_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_26"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_26_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_27"){
                if(sResTarget=="set_27_oba"||sResTarget=="set_27_och"||sResTarget=="set_27_ost")
                    CreateItemOnObject("craft_27_och",oPC);
                else if(sResTarget=="set_27_ggu"||sResTarget=="set_27_gsf"||sResTarget=="set_27_gar"||sResTarget=="set_27_gsc"||sResTarget=="set_27_gga")
                    CreateItemOnObject("craft_27_gga",oPC);
            }

            else if(sTagTarget=="set_28"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_28_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_29"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_29_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_30"){
                if(sResTarget=="set_30_lun"||sResTarget=="set_30_lnf")
                    CreateItemOnObject("craft_30_lun",oPC);
                else if(sResTarget=="set_30_orp"||sResTarget=="set_30_opa")
                    CreateItemOnObject("craft_30_orp",oPC);
                else if(sResTarget=="set_30_tgu"||sResTarget=="set_30_tca"||
                sResTarget=="set_30_tma"||sResTarget=="set_30_tga"||sResTarget=="set_30_tco")
                    CreateItemOnObject("craft_30_tgu",oPC);
            }
            else if(sTagTarget=="set_31"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_31_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_32"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_32_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_33"){
                if(sResTarget=="set_33_cob"||sResTarget=="set_33_cco"||
                sResTarget=="set_33_chc"||sResTarget=="set_33_tco")
                    CreateItemOnObject("craft_33_cob",oPC);
                else if(sResTarget=="set_33_dta"||sResTarget=="set_33_dte"||sResTarget=="set_33_dan")
                    CreateItemOnObject("craft_33_dta",oPC);
            }
            else if(sTagTarget=="set_34"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_34_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_35"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_35_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_36"){
                if(sResTarget=="set_36_fla"||sResTarget=="set_36_fgu"||sResTarget=="set_36_fca")
                    CreateItemOnObject("craft_36_fla",oPC);
                else if(sResTarget=="set_36_sgu"||sResTarget=="set_36_sba"||sResTarget=="set_36_sst")
                    CreateItemOnObject("craft_36_sgu",oPC);
            }
            else if(sTagTarget=="set_37"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_37_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_38"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_38_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_39"){
                if(sResTarget=="set_39_vcu"||sResTarget=="set_39_vgi"||sResTarget=="set_39_vad")
                    CreateItemOnObject("craft_39_vcu",oPC);
                else if(sResTarget=="set_39_tch"||sResTarget=="set_39_tro"||sResTarget=="set_39_tca")
                    CreateItemOnObject("craft_39_tro",oPC);
            }
            else if(sTagTarget=="set_40"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_40_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_41"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_41_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_42"){
                if(sResTarget=="set_42_gep"||sResTarget=="set_42_gem"||sResTarget=="set_42_geg"||sResTarget=="set_42_cub")
                    CreateItemOnObject("craft_42_gep",oPC);
                else if(sResTarget=="set_42_dop"||sResTarget=="set_42_din"||sResTarget=="set_42_dze")
                    CreateItemOnObject("craft_42_dop",oPC);
            }
            else if(sTagTarget=="set_43"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_43_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_44"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_44_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_45"){
                if(sResTarget=="set_45_ysa"||sResTarget=="set_45_yma"||sResTarget=="set_45_yab")
                    CreateItemOnObject("craft_45_ysa",oPC);
                else if(sResTarget=="set_45_lml"||sResTarget=="set_45_lma"||sResTarget=="set_45_lmf")
                    CreateItemOnObject("craft_45_lml",oPC);
            }
            else if(sTagTarget=="set_46"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_46_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_47"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_47_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_48"){
                if(sResTarget=="set_48_sah"||sResTarget=="set_48_sac"||sResTarget=="set_48_sas")
                    CreateItemOnObject("craft_48_sah",oPC);
            }
            else if(sTagTarget=="set_49"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_49_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_50"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_50_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_51"){
                if(sResTarget=="set_51_tvi"||sResTarget=="set_51_tvd"||sResTarget=="set_51_tvs")
                    CreateItemOnObject("craft_51_tvi",oPC);
                else if(sResTarget=="set_51_tfa"||sResTarget=="set_51_tfc"||sResTarget=="set_51_tfm")
                    CreateItemOnObject("craft_51_tfa",oPC);
            }
            else if(sTagTarget=="set_61"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_61_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_63"){
                if(sResTarget=="set_63_bna"||sResTarget=="set_63_bgn"||sResTarget=="set_63_bel"||sResTarget=="set_63_bum")
                    CreateItemOnObject("craft_63_bna",oPC);
            }
            else if(sTagTarget=="set_73"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_73_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_75"){
                if(sResTarget=="set_75_eac"||sResTarget=="set_75_eam"||sResTarget=="set_75_eaa")
                    CreateItemOnObject("craft_75_eac",oPC);
            }
            else if(sTagTarget=="set_76"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_76_bos2",oPC);
                }
            }
            else if(sTagTarget=="set_78"){
                if(sResTarget=="set_78_ggm"||sResTarget=="set_78_ggf"||sResTarget=="set_78_ggs")
                    CreateItemOnObject("craft_78_ggm",oPC);
            }
            break;
        //CASI DEI BOSS AL 50%
        case 6: case 7: case 8: case 9: case 10:
            if(sResTarget=="set_1_rat_bos"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_1_rat_bos3",oPC);
                }
            }
            else if(sResTarget=="set_3_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_3_bos3",oPC);
                    }
            }
            else if(sResTarget=="set_4_mb1"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_4_mb13",oPC);
                    }
            }
            else if(sResTarget=="set_4_mb2"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_4_mb23",oPC);
                    }
            }
            else if(sResTarget=="set_4_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_4_bos3",oPC);
                    }
            }
            else if(sResTarget=="set_6_bos"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_6_bos3",oPC);
                }
            }
            else if(sResTarget=="set_7_bos"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_7_bos3",oPC);
                }
            }
            else if(sResTarget=="set_8_bos"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_8_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_10"){
                if(sResTarget=="set_10_mb1"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_10_mb13",oPC);
                        }
                }
                else if(sResTarget=="set_10_bos"){
                        if(i<3){
                            Scalcare(oPC,sTagTarget,sResTarget,i+1);
                            CreateItemOnObject("craft_10_bos3",oPC);
                        }
                }
            }
            else if(sTagTarget=="set_11"){
                if(sResTarget=="set_11_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_11_bos3",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_12"){
               if(sResTarget=="set_12_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_12_bos3",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_13"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_13_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_14"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_14_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_16"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_16_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_17"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_17_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_19"){
               if(sResTarget=="set_19_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_19_bos3",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_20"){
               if(sResTarget=="set_20_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_20_bos3",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_22"){
               if(sResTarget=="set_22_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_22_bos3",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_23"){
               if(sResTarget=="set_23_bos"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_23_bos3",oPC);
                    }
                }
                else if(sResTarget=="set_23_mb1"){
                    if(i<3){
                        Scalcare(oPC,sTagTarget,sResTarget,i+1);
                        CreateItemOnObject("craft_23_mb13",oPC);
                    }
                }
            }
            else if(sTagTarget=="set_25"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_25_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_26"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_26_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_28"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_28_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_29"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_29_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_31"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_31_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_32"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_32_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_34"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_34_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_35"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_35_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_37"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_37_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_38"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_38_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_40"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_40_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_41"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_41_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_43"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_43_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_44"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_44_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_46"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_46_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_47"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_47_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_49"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_49_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_50"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_50_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_61"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_61_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_73"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_73_bos3",oPC);
                }
            }
            else if(sTagTarget=="set_76"){
                if(i<3){
                    Scalcare(oPC,sTagTarget,sResTarget,i+1);
                    CreateItemOnObject("craft_76_bos3",oPC);
                }
            }
            else
                SendMessageToPC(oPC,"Non sei riuscito a ricavare nulla dal corpo");
        break;
    }
}

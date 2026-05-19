
int nNumberRandom(int nDice,int nValue);

int nNumberRandom(int nDice,int nValue){
    int i;
    int nRandom=0;
    for(i==0;i<nValue;i++){
        nRandom = nRandom + (Random(nDice)+1);
    }
    return nRandom;
}

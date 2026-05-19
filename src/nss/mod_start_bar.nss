void main()
{
    // Variabile generica
    int i = GetLocalInt(OBJECT_SELF,"timer");
    // Incrementiamo la variabile per usarla come un timer
    i++;
    // Quando arriviamo a 18 secondi facciamo parlare la barda
    if(i==3){
        SpeakString("Avvicinate ad ascoltare la storia di Lyris, una storia che fonde leggende e misteri");
        i==0;
    }
    // Impostiamo il timer aggiornato
    SetLocalInt(OBJECT_SELF,"timer",i);
}

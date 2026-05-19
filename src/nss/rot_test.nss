void Rotation(object oBarca,float fChange){
    AssignCommand(oBarca,DelayCommand(0.1,SetFacing(fChange-2.0)));
    AssignCommand(oBarca,DelayCommand(0.2,SetFacing(fChange-4.0)));
    AssignCommand(oBarca,DelayCommand(0.3,SetFacing(fChange-6.0)));
    AssignCommand(oBarca,DelayCommand(0.4,SetFacing(fChange-8.0)));
    AssignCommand(oBarca,DelayCommand(0.5,SetFacing(fChange-10.0)));
    AssignCommand(oBarca,DelayCommand(0.6,SetFacing(fChange-12.0)));
    AssignCommand(oBarca,DelayCommand(0.7,SetFacing(fChange-14.0)));
    AssignCommand(oBarca,DelayCommand(0.8,SetFacing(fChange-16.0)));
    AssignCommand(oBarca,DelayCommand(0.9,SetFacing(fChange-18.0)));
    AssignCommand(oBarca,DelayCommand(1.0,SetFacing(fChange-20.0)));
    AssignCommand(oBarca,DelayCommand(1.1,SetFacing(fChange-22.0)));
    AssignCommand(oBarca,DelayCommand(1.2,SetFacing(fChange-24.0)));
    AssignCommand(oBarca,DelayCommand(1.3,SetFacing(fChange-26.0)));
    AssignCommand(oBarca,DelayCommand(1.4,SetFacing(fChange-28.0)));
    AssignCommand(oBarca,DelayCommand(1.5,SetFacing(fChange-30.0)));
    AssignCommand(oBarca,DelayCommand(1.6,SetFacing(fChange-32.0)));
    AssignCommand(oBarca,DelayCommand(1.7,SetFacing(fChange-34.0)));
    AssignCommand(oBarca,DelayCommand(1.8,SetFacing(fChange-36.0)));
    AssignCommand(oBarca,DelayCommand(1.9,SetFacing(fChange-38.0)));
    AssignCommand(oBarca,DelayCommand(2.0,SetFacing(fChange-40.0)));
    AssignCommand(oBarca,DelayCommand(2.1,SetFacing(fChange-42.0)));
    AssignCommand(oBarca,DelayCommand(2.2,SetFacing(fChange-44.0)));
    AssignCommand(oBarca,DelayCommand(2.3,SetFacing(fChange-46.0)));
    AssignCommand(oBarca,DelayCommand(2.4,SetFacing(fChange-48.0)));
    AssignCommand(oBarca,DelayCommand(2.5,SetFacing(fChange-50.0)));
    AssignCommand(oBarca,DelayCommand(2.6,SetFacing(fChange-52.0)));
    AssignCommand(oBarca,DelayCommand(2.7,SetFacing(fChange-54.0)));
    AssignCommand(oBarca,DelayCommand(2.8,SetFacing(fChange-56.0)));
    AssignCommand(oBarca,DelayCommand(2.9,SetFacing(fChange-58.0)));
    AssignCommand(oBarca,DelayCommand(3.0,SetFacing(fChange-60.0)));
    AssignCommand(oBarca,DelayCommand(3.1,SetFacing(fChange-62.0)));
    AssignCommand(oBarca,DelayCommand(3.2,SetFacing(fChange-64.0)));
    AssignCommand(oBarca,DelayCommand(3.3,SetFacing(fChange-66.0)));
    AssignCommand(oBarca,DelayCommand(3.4,SetFacing(fChange-68.0)));
    AssignCommand(oBarca,DelayCommand(3.5,SetFacing(fChange-70.0)));
    AssignCommand(oBarca,DelayCommand(3.6,SetFacing(fChange-72.0)));
    AssignCommand(oBarca,DelayCommand(3.7,SetFacing(fChange-74.0)));
    AssignCommand(oBarca,DelayCommand(3.8,SetFacing(fChange-76.0)));
    AssignCommand(oBarca,DelayCommand(3.9,SetFacing(fChange-78.0)));
    AssignCommand(oBarca,DelayCommand(4.0,SetFacing(fChange-80.0)));

}

void main()
{
    object oBarca = OBJECT_SELF;
    float fFacing = GetFacing(oBarca);
    Rotation(oBarca,fFacing);
}

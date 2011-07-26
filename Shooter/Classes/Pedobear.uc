class Pedobear extends ShootablePawn;

function OnTouch(Actor TouchedBy, EZoneTouchEVent Type, float X, float Y)
{
    PlaySound(SoundCue'KismetGame_Assets.Sounds.Snake_Death_Cue',False,True);
    DestroyMe();
    
    if(ShooterPC(TouchedBy) != none)
    		ShooterGame(WorldInfo.Game).UpdateScore(ShooterPC(TouchedBy), Self);
}

defaultproperties
{
    MyType=PT_BEAR
    MatInst0=Material'Dev_Materials.M_DevSolidRed'
    //MatInst1=Material'Dev_Materials.M_DevSolidBrown'
}
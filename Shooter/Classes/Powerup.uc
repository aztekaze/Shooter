class Powerup extends ShootablePawn;

//PowerupType
//0 = Freeze Powerup
//1 = Ammo Powerup
//2 = Wrath Powerup
var int PuT;

function OnTouch(Actor TouchedBy, EZoneTouchEvent Type, float X, float Y)
{
    local ShooterPC PC;
    PC = ShooterPC(TouchedBy);
    switch(PuT)
    {
        //Freeze
        case 0:
           PC.Freeze();
           break;
        //Ammo
        case 1:
           PC.Ammo();
           break;
        //Wrath
        case 2:
           PC.Wrath();
           break;
        default:
           break;
    }
    DestroyMe();
}

function Init(vector move, float rate, float delta)
{
    PuT = Rand(3);
    switch(PuT)
    {
        //Freeze
        case 0:
           MatInst0=Material'Dev_Materials.M_SkyGradient';
           break;
        //Ammo
        case 1:
           MatInst0=Material'Dev_Materials.M_DevSolidBrown';
           break;
        //Wrath
        case 2:
           MatInst0=Material'Dev_Materials.M_DevSolidGray';
           break;
        default:
           break;
    }
    Super.Init(move, rate, delta);
    Rot.yaw -= 16384.0;
    SetRotation( Rot );
    SetTimer( 10.0 );
}

function Timer()
{
    WorldInfo.Game.Broadcast(self, "I didn't get used.");
    DestroyMe();
}

defaultproperties
{
     Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'Project_Meshes.SM_CardboardCharTest'
        Scale=0.5
        BlockActors=false
	End Object
    S_Mesh=StaticMeshComponent0

    MyType=PT_POWERUP
 	RunMultiplier=10.0
}
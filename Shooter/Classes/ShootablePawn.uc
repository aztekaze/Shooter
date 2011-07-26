class ShootablePawn extends MobilePlaceablePawn implements(ITouchable)
    ClassGroup(ShooterGameStuff);

//Direction shootable is facing when spawned
var vector                   AimDir;

//Mesh info
var StaticMeshComponent      S_Mesh;

//There are 2 materials to switch from
var int                      CurrentMat;
var Material                 MatInst0,MatInst1;
//Material toggle rate
var float                    FlickerRate;

var bool                     bShootable;

var rotator                  Rot;

var vector                   Paws;

var() float                  MaxRunSpeed,RunSpeed,SpeedUpRate,SpeedUpDelta;

var float                    RunMultiplier;

var int						WorthScore;

var enum PawnType
{
    PT_BEAR,
    PT_CHILD,
    PT_POWERUP
}MyType;

function OnTouch(Actor TouchedBy, EZoneTouchEVent Type, float X, float Y);

function Init(vector move, float rate, float delta)
{
    AimDir = Normal(Move - Location);
    Rot = Rotator(AimDir);
    Rot.yaw += 16384.0;
    Rot.pitch = 0.0;
    Rot.roll = 0.0;
    SetRotation( Rot );
    Velocity = RunSpeed * RunMultiplier * AimDir;
    Acceleration = AccelRate * AimDir;
    S_Mesh.SetMaterial(0,MatInst0);
    SpeedUpRate = rate;
    SpeedUpDelta = delta;
    SetTimer( FlickerRate, True, NameOf(ToggleMaterial) );
    SetTimer( SpeedUpRate, True, NameOf(SpeedUp) );
}

function SpeedUp()
{
    if(RunSpeed >= MaxRunSpeed)
    {
        RunSpeed += SpeedUpDelta;
    }
    else
        ClearTimer(Nameof(SpeedUp));
}

function ToggleMaterial()
{
    if(CurrentMat == 1)
    {
        S_Mesh.SetMaterial(0,MatInst0);
        CurrentMat=0;
    }
    else
    {
        S_Mesh.Setmaterial(0,MatInst1);
        CurrentMat=1;
    }
}

function DestroyMe()
{
    ClearTimer(NameOf(ToggleMaterial));
    self.Destroy();
}

function pawntype GetPawnType()
{
    return MyType;
}

function Frozen()
{
    Acceleration = 0 * AimDir;
    Velocity = 0 * AimDir;
}

function Thawed()
{
    Acceleration = AccelRate * AimDir;
    Velocity = RunSpeed * RunMultiplier * AimDir;
}

defaultproperties
{
    Begin Object class=StaticMeshComponent Name=StaticMeshComponent0
		StaticMesh=StaticMesh'Project_Meshes.SM_CardboardCharTest'
        Scale=1.5
        Translation=(X=0.000000,Y=0.000000,Z=-48.000000)
        BlockActors=false
        CollideActors=true
	End Object
    S_Mesh=StaticMeshComponent0

    Components.Add(StaticMeshComponent0)

	AccelRate=4096.0000
    RunSpeed=100
    MaxRunSpeed=1000
    GroundSpeed=600
    
    RunMultiplier = 5.0;

    SpeedUpRate=1.0
    SpeedUpDelta=100.0

	bShootable=True

    MatInst0=Material'Dev_Materials.M_DevSolidBlue'
    MatInst1=Material'Dev_Materials.M_DevSolidBrown'
    
    CurrentMat=0
    FlickerRate=0.45

    Paws = (X=0.0,Y=0.0,Z=0.0)
}
class ShooterGame extends MobileGame;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    WorldInfo.Game.Broadcast( self, "Using the ShooterGame game type" );
    `log("-----Using the ShooterGame game type-----");
}

function Pause()
{
    local ShootablePawn SP;
    local ShootableSpawner SS;
    foreach DynamicActors( class'ShootablePawn', SP )
        SP.Frozen();
    foreach DynamicActors( class'ShootableSpawner', SS )
        SS.Paused();
}

function Resume()
{
    local ShootablePawn SP;
    local ShootableSpawner SS;
    foreach DynamicActors( class'ShootablePawn', SP )
        SP.Thawed();
    foreach DynamicActors( class'ShootableSpawner', SS )
        SS.UnPaused();
}

function UpdateScore(Controller Killer, Pawn Other)
{
  if(ShootablePawn(Other) != none && ShooterPawn(Killer.Pawn) != none)
  {
  	ShooterPC(Killer).CurrentScore += ShootablePawn(Other).WorthScore;

  	`log("Player Score: "$ShooterPC(Killer).CurrentScore);
  }
}

defaultproperties
{
    PlayerControllerClass=class'Shooter.ShooterPC'
    HUDType=class'Shooter.ShooterHUD'
    DefaultPawnClass=class'Shooter.ShooterPawn'
    bRestartLevel=true
    bDelayedStart=false
}



class ShooterPC extends MobilePC;

/** Holds the dimensions of the device's screen */
var vector2D          ViewportSize;

/** If TRUE, a new touch was detected (must be the only touch active) */
var bool              bPendingTouch;

/** Holds the handle of the most recent touch */
var int               PendingTouchHandle;

/** Holds the Actor that was selected */
var Actor             SelectedActor;

/** Maximum distance an Actor can be to be picked */
var float             PickDistance;

/** Maximum amount the mouse can move between touch and untouch to be considered a 'click' */
var float             ClickTolerance;

var Vector            NodeLoc;

var Vector2D          ShootingAt;

var int               AmmoCount, PlayerScore;

var float             FireRate;

var bool              bPaused;

var class<MobileMenuScene> MainMenuClass;
var class<MobileMenuScene> MidgameMenuClass;

//Scoring
var int 					CurrentScore;
var int					HighScores[3];

exec function Freeze()
{
    Paws();
    SetTimer( 5.0,,NameOf(UnFreeze) );
} 

exec function Paws()
{
    bPaused = true;
    ShooterGame(WorldInfo.Game).Pause();
}

exec function Wrath()
{
    local ShootablePawn SP;
    foreach DynamicActors( class'ShootablePawn', SP )
        SP.DestroyMe();
}

exec function Ammo()
{
    AddAmmo(25);
}

exec function Oufofmain();

exec function UnFreeze()
{
    bPaused = false;
    ShooterGame(WorldInfo.Game).Resume();
}


simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    //WorldInfo.Game.Broadcast( self, "using the ShooterPC player controller" );
    `log("-----Using the ShooterPC player controller-----");
    SetTimer(1.5,false,Nameof(MPointSpawn));
}

function MPointSpawn()
{
    //set a vector behind (x=-256) the player for the bears and children to move to
    NodeLoc = Pawn.Location + NodeLoc;
}

/** find actor under touch location
*
*   @PickLocation - Screen coordinates of touch 
*/
function Actor PickActor(Vector2D PickLocation)
{
   local Vector TouchOrigin, TouchDir;
   local Vector HitLocation, HitNormal;
   local Actor PickedActor;

   //Transform absolute screen coordinates to relative coordinates
   PickLocation.X = PickLocation.X / ViewportSize.X;
   PickLocation.Y = PickLocation.Y / ViewportSize.Y;

   //Transform to world coordinates to get pick ray
   LocalPlayer(Player).Deproject(PickLocation, TouchOrigin, TouchDir);
   
   //Perform trace to find touched actor
   PickedActor = Trace(HitLocation, HitNormal, TouchOrigin + (TouchDir * PickDistance), TouchOrigin, true);
   
   //Casting to ITouchable determines if the touched actor can indeed be touched
   if(Itouchable(PickedActor) != none)
   {
      //Call the OnTouch() function on the touched actor
      Itouchable(PickedActor).OnTouch(self, ZoneEvent_Touch, PickLocation.X, PickLocation.Y);
   }
   
   //Return the touched actor for good measure
   return PickedActor;
}

function ReadyFire(Vector2D FireTarget)
{
    UpdateFire(FireTarget);
    Firing();
}

function Firing()
{
    local Actor PickedActor;
    //Get actor under touch
    if(GetAmmoCount() > 0)
    {
        UseAmmo();
        PickedActor = PickActor(ShootingAt);
        PlaySound( SoundCue'KismetGame_Assets.Sounds.S_Blast_05_Cue', FALSE, TRUE );
         
        //Check if actor is touchable and set it as selected; clear current selected if not
        if(ITouchable(PickedActor) != none)
        {
            SelectedActor = PickedActor;
        }
        else
        {
            SelectedActor = none;
        }
    }
    else
    {
        PlaySound(SoundCue'KismetGame_Assets.Sounds.S_WeaponPickup_02_Cue', False, True);
    }
    SetTimer(FireRate,true,Nameof(Firing));
}

function EndFire()
{
    ClearTimer(Nameof(Firing));
}

function UpdateFire(Vector2D FireTarget)
{
    ShootingAt = FireTarget;
}

/*
function Vector2D GetAim()
{
    return ShootingAt;
}
*/

function int GetAmmoCount()
{
    return AmmoCount;
}

function AddAmmo(int amount)
{
    AmmoCount += amount;
}

function UseAmmo()
{
    AmmoCount--;
}

function HandleInputTouch(int Handle, EZoneTouchEvent Type, Vector2D TouchLocation, float DeviceTimestamp, int TouchpadIndex)
{
   local int i;
   
   //New touch event
   if(Type == ZoneEvent_Touch)
   {      
      //Specify a new touch has occurred
      PendingTouchHandle = Handle;
      bPendingTouch = true;  
      if(!bPaused)
        ReadyFire(TouchLocation);
   }
   //Touch in progress
   else if(Type == ZoneEvent_Update)
   {   
      for(i=0; i<MPI.NumTouchDataEntries; i++)
      {
         //Test distance touch has moved and cancel touch if moved too far; update touch location if not
         if(MPI.Touches[i].Handle == PendingTouchHandle && MPI.Touches[i].TotalMoveDistance > ClickTolerance)
         {
            bPendingTouch = false;
         }
         else
         {
            if(!bPaused)
              UpdateFire(TouchLocation);
         }
      }
   }
   //End of touch
   else if(Type == ZoneEvent_Untouch)
   {
      //Check if a touch is active
      if(Handle == PendingTouchHandle && bPendingTouch)
      {
         //cancel active touch
         bPendingTouch = false;
         EndFire();
      }
   }
}

function vector GetMovePoint()
{
    return NodeLoc;
}

function vector GetLocation()
{
    return Location;
}

function BearAttack()
{
    if(AmmoCount > 0)
    {
        AmmoCount -= 10;
        if(AmmoCount<0)
          AmmoCount = 0;
    }
    else
    {
        WorldInfo.Game.Broadcast(self, "You lose.");
        Paws();
        SetTimer(5.0, false, Nameof(RestartGame));
    }
}

function RestartGame()
{
    ConsoleCommand("RestartLevel");
}

function ChildSafe()
{
    AmmoCount += 10;
}


event InitInputSystem()
{
    local ShooterMenu_Base MainMenu,MidMenu;

    Super.InitInputSystem();

    //Get a reference to the local MobilePlayerInput
    MPI = MobilePlayerInput(PlayerInput);

    //Assing the input handler function to the delegate
    MPI.OnInputTouch = HandleInputTouch;

    //get the screen dimensions (used to transform to relative screen coords for the DeProject)
    LocalPlayer(Player).ViewportClient.GetViewportSize(ViewportSize);

    Paws();

    MidMenu = ShooterMenu_Base(MPI.OpenMenuScene(MidgameMenuClass));
    MainMenu = ShooterMenu_Base(MPI.OpenMenuScene(MainMenuClass));

    //Menu needs access to exec functions.
    MainMenu.SetController(self);
    MidMenu.SetController(self);
}


function UpdateRotation( float DeltaTime )
{
    //Zot
}


defaultproperties
{
    PickDistance=20560
    ClickTolerance=5
    AmmoCount=100
    FireRate=0.125
    PlayerScore=0
    bPaused=true

    NodeLoc=(X=-256.0000,Y=0.0000,Z=0.0000)
    
    MainMenuClass=class'Shooter.ShooterMenu_Main'
    MidgameMenuClass=class'Shooter.ShooterMenu_Midgame'
}




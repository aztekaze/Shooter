class ShootableSpawner extends Actor
    placeable
    ClassGroup(ShooterGameStuff);

//Class created each spawn
var() class<ShootablePawn>        SpawningClass;

//Only affects y radius, spawns will happen randomly within
var() float                       SpawnRadius;

//Spawner active
var() bool                        bSpawning;

//Player Controller, contains the move target vector
var   ShooterPC                   GamePlayer;

//How fast the shootables will spawn
var()   float                     RespawnRate,MaxRespawnRate,RespawnSpeedUpRate,RespawnSpeedUpDelta,SpeedUpRate,SpeedUpDelta;

//Holder for spawn location
var   vector                      Destination;

function SpawnEffects()
{
    if(RespawnRate >= MaxRespawnRate)
        RespawnRate -= RespawnSpeedUpDelta;
    else
        ClearTimer(Nameof(SpawnEffects));
}


/*function class<ShootablePawn> GetSpawningClass()
{
    return SpawningClass;
}*/

function Paused()
{
    bSpawning = false;
    ClearTimer(NameOf(SpawnEffects));
    GotoState('Waiting');
    //WorldInfo.Game.Broadcast( self, "Spawner has been paused." );
}

function UnPaused()
{
    bSpawning = true;
    SetTimer( RespawnSpeedUpRate, true, NameOf(SpawnEffects));
    GotoState('Setup');
    //WorldInfo.Game.Broadcast( self, "Spawner has been unpaused" );
}


//******************************************************************************
//Setup State
//
//  Functions that required a small delay
//  Also sets Gameplayer.
//******************************************************************************
auto state Setup
{
    function FindPlayer()
    {
        local ShooterPC tempPC;
        
        foreach DynamicActors(class'ShooterPC', tempPC)
        {
            if(tempPC != none)
            {
                GamePlayer = tempPC;
                Destination = Location;
                SetTimer( SpeedUpRate, true, NameOf(SpawnEffects));
                GotoState('Waiting');
            }
            else
            {
                WorldInfo.Game.Broadcast( self, "Can't find the player" );
            }
        }
        
        if(tempPC == none)
        {
        		`log("Unhandled Exception!");
        }
    }


    Begin:
        FindPlayer();
}

//******************************************************************************
//Waiting State
//
// Makes sure it is allowed to spawn.  a.k.a. Idle
//******************************************************************************
state Waiting
{
    function CheckSpawning()
    {
        if(bSpawning)
        {
            SetTimer( RespawnRate, false, Nameof(StartSpawn) );
            //WorldInfo.Game.Broadcast( self, "Checkspawning, bSpawning" );
        }
        else
        {
            SetTimer( RespawnRate, true, Nameof(NotSpawning) );
            //WorldInfo.Game.Broadcast( self, "Checkspawning, !bSpawning" );
        }
    }
    
    function NotSpawning()
    {
        //WorldInfo.Game.Broadcast( self, "NotSpawning" );
        if( bSpawning )
        {
            ClearTimer(Nameof(NotSpawning));
            CheckSpawning();
        }
    }

    function StartSpawn()
    {
        GotoState('Spawning');
    }
        
    Begin:
        CheckSpawning();
}



//******************************************************************************
//Spawning State
//
// Magic
//******************************************************************************
state Spawning
{
    function SetSpawnZone()
    {
        local float  DirY;

        //We want negative radius as well.
        DirY = FRand() * 2 * SpawnRadius - SpawnRadius;

        Destination.X = Location.X;
        Destination.Y = Location.Y + DirY;
        Destination.Z = Location.Z;

        if(bSpawning)
          SpawnSpawnable();
    }

    function SpawnSpawnable()
    {
        local ShootablePawn Spawnee;

        if(SpawningClass == none)
        {
            GotoState('Waiting');
        }
        else
        {
        	//FIXME: GamePlayer == none causing accessed nones
//        		if(GamePlayer != none)
//        		{
				Spawnee = Spawn(SpawningClass,,,Destination);
				if(Spawnee == none)
				{
					SetTimer( 0.5, false, NameOf(SetSpawnZone) );
				}
				else
				{
					Spawnee.Init(GamePlayer.GetMovepoint(), SpeedUpRate, SpeedUpDelta);
					GotoState('Waiting');
				}
				
				if(SpawningClass == class'Shooter.Pedobear')
				{
					Spawnee.WorthScore = WorldInfo.TimeSeconds * 1;
				}
//			}
        }
   }

    Begin:
       SetSpawnZone();
}

defaultproperties
{
    SpawningClass=none
    RespawnRate=5.0
    MaxRespawnRate=1
    SpawnRadius=256.0
    bSpawning=true
    SpeedUpRate=5.0
    SpeedUpDelta=0.5
}



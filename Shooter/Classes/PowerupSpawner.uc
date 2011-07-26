class PowerupSpawner extends ShootableSpawner;

var vector PowerupMovePoint;

state Spawning
{
    function SpawnSpawnable()
    {
        local ShootablePawn Spawnee;

        if( SpawningClass == none )
        {
            //WorldInfo.Game.Broadcast( self, "Don't Spawn from default ShootableSpawner class");
            GotoState('Waiting');
        }
        else
        {
            //WorldInfo.Game.Broadcast( self, "Trying to Spawn at:"@Destination );
            Spawnee = Spawn( SpawningClass,,,Destination);
            if(Spawnee == none)
            {
                //WorldInfo.Game.Broadcast( self, "Didn't spawn the spawnee." );
                SetTimer( 0.5, false, Nameof(SetSpawnZone) );
            }
            else
            {
                GotoState('Waiting');
                SetupMovePoint();
                Spawnee.Init(PowerupMovePoint, SpeedUpRate, SpeedUpDelta);
            }
        }
    }
}

function SetupMovePoint()
{
    PowerupMovePoint   = GamePlayer.GetLocation();
    PowerupMovePoint.y = PowerupMovePoint.y - location.y + PowerupMovePoint.y;
    PowerupMovePoint.x = location.x;
    PowerupMovePoint.z = location.z;
}

defaultproperties
{
    SpawningClass=class'Shooter.Powerup'
    RespawnRate=5.0
    SpawnRadius=0.0
    bSpawning=true
}
class ShooterPawn extends MobilePawn;

var vector FireTarget;

event Touch (Actor Other, PrimitiveComponent OtherComp, Object.Vector HitLocation, Object.Vector HitNormal)
{
    local ShootablePawn p;
    P = ShootablePawn(Other);

    if( P.GetPawnType() == PT_BEAR )
    {
      ShooterPC(controller).BearAttack();
      WorldInfo.Game.Broadcast(self, "A Bear Attacks");
    }
    else if( P.GetPawnType() == PT_CHILD )
    {
      ShooterPC(controller).ChildSafe();
      WorldInfo.Game.Broadcast(self, "A Child is Safe");
    }
    P.DestroyMe();
}

defaultproperties
{
    bBlockActors=false
}



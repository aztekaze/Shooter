class ShooterHUD extends MobileHUD;

var vector2d ScorePosition;

simulated function PostBeginPlay()
{
    super.postbeginplay();
    WorldInfo.Game.Broadcast( self, "using the ShooterHUD head up display" );
    `log("-----using the ShooterHUD head up display-----");
}

/*event tick(float deltatime)
{
    //WorldInfo.Game.Broadcast( self, "using the ShooterHUD" );
}*/

function DrawInventory(String Title,int Value,int X, int Y, int R, int G, int B)
{
    local float strlengthX, strlengthY;

    Canvas.SetPos(X, Y); //Change 200 to however big your bar is
    Canvas.SetDrawColor(R, G, B, 200);
    Canvas.Font = class'Engine'.static.GetSmallFont();
    Canvas.DrawText(Title);
    
    Canvas.StrLen(Title,strlengthX,strlengthY);
    Canvas.SetPos(X+strlengthX,Y);
    Canvas.DrawText(":");
    
    Canvas.SetPos(X+strlengthX+10,Y);
    Canvas.DrawText(value);
}

function DrawHud()
{
    DrawInventory("Ammo",ShooterPC(PlayerOwner).GetAmmoCount(),20,5,255,126,126); //...draw our AmmoCount
    DrawScore();
    Super.DrawHud();
}

function DrawScore()
{
	 Canvas.SetPos(ScorePosition.X, ScorePosition.Y);
	 Canvas.Font = class'Engine'.static.GetSmallFont();
	 Canvas.DrawText(ShooterPC(PlayerOwner).CurrentScore);
}

defaultproperties
{
	ScorePosition=(X=245,Y=245)
}



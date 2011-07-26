class ShooterMenu_Base extends MobileMenuScene;

var ShooterPC MyController;

function SetController( ShooterPC PC )
{
    MyController = PC;
}

function MenuClosing()
{

}

function OnTouch(MobileMenuObject Sender,float TouchX, float TouchY, bool bCancel)
{
   if(Sender == none)
   {
      return;
   }
   
   if(bCancel)
   {
      return;
   }
   
   if(Sender.Tag ~= "PLAY")
   {
      MyController.UnFreeze();
      InputOwner.CloseMenuScene(self);
      MyController.ConsoleCommand("Outofmain");
   }
   
   if(Sender.Tag ~= "BACK")
   {
      InputOwner.CloseMenuScene(self);
   }
}

defaultproperties
{
   Left=0
   Top=0
   Width=1.0
   Height=180.0
   bRelativeWidth=true
}
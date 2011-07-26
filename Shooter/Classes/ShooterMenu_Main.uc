class ShooterMenu_Main extends ShooterMenu_Base;

var class<ShooterMenu_Base> HSMenuClass;

function OnTouch(MobileMenuObject Sender,float TouchX, float TouchY, bool bCancel)
{
    Super.OnTouch( Sender, TouchX, TouchY, bCancel );
    
    if(Sender.Tag ~= "HIGHSCORES")
    {
         InputOwner.OpenMenuScene(HSMenuClass);
    }
}

defaultproperties
{
   Begin Object Class=MobileMenuImage Name=Background
      Tag="Background"
      Left=0
      Top=0
      Width=1.0
      Height=4.0
      bRelativeWidth=true
      bRelativeHeight=true
      Image=Texture2D'Game_Materials.chest'
      ImageDrawStyle=IDS_Stretched
      ImageUVs=(bCustomCoords=true,U=0,V=670,UL=455,VL=354)
   End Object
   MenuObjects.Add(Background)
   
   Begin Object Class=MobileMenuImage Name=TitleImage
      Tag="Title"
      Left=10
      Top=10
      Width=260
      Height=60
      TopLeeway=20
      Image=Texture2D'CastleUI.menus.T_CastleMenu2'
      ImageUVs=(bCustomCoords=true,U=129,V=736,UL=260,VL=60)
   End Object
   MenuObjects.Add(TitleImage)

   Begin Object Class=MobileMenuButton Name=PlayButton
      Tag="PLAY"
      Left=0.05
      Top=0.75
      Width=140
      Height=24
      bRelativeLeft=true
      bRelativeTop=true
      TopLeeway=20
      Images(0)=Texture2D'CastleUI.menus.T_CastleMenu2'
      Images(1)=Texture2D'CastleUI.menus.T_CastleMenu2'
      ImagesUVs(0)=(bCustomCoords=true,U=306,V=220,UL=310,VL=48)
      ImagesUVs(1)=(bCustomCoords=true,U=306,V=271,UL=310,VL=48)
   End Object
   MenuObjects.Add(PlayButton)

   Begin Object class=UDNMobileMenuLabel name=LabelPlay
      Tag="LPlay"
      Caption="Play"
      Height=32
      Width=80
      Left=.2
      Top=.75
      TextFont=Font'EngineFonts.SmallFont'
      bRelativeLeft=true
      bRelativeTop=true
      CaptionColor=(R=1.0,G=1.0,B=1.0,A=1.0)
      BackgroundColor=(R=1.0,G=1.0,B=1.0,A=0.0)
   End Object
   MenuObjects.Add(LabelPlay)

   Begin Object Class=MobileMenuButton Name=InstrucButton
      Tag="INSTRUCTION"
      Left=0.05
      Top=1.5
      Width=140
      Height=24
      bRelativeLeft=true
      bRelativeTop=true
      TopLeeway=20
      Images(0)=Texture2D'CastleUI.menus.T_CastleMenu2'
      Images(1)=Texture2D'CastleUI.menus.T_CastleMenu2'
      ImagesUVs(0)=(bCustomCoords=true,U=306,V=220,UL=310,VL=48)
      ImagesUVs(1)=(bCustomCoords=true,U=306,V=271,UL=310,VL=48)
   End Object
   MenuObjects.Add(InstrucButton)

   Begin Object class=UDNMobileMenuLabel name=LabelInstruc
      Tag="LInstruction"
      Caption="Instructions"
      Height=32
      Width=120
      Left=.20
      Top=1.5
      TextFont=Font'EngineFonts.SmallFont'
      bRelativeLeft=true
      bRelativeTop=true
      CaptionColor=(R=1.0,G=1.0,B=1.0,A=1.0)
      BackgroundColor=(R=1.0,G=1.0,B=1.0,A=0.0)
   End Object
   MenuObjects.Add(LabelInstruc)
   
   Begin Object Class=MobileMenuButton Name=OptionButton
      Tag="OPTION"
      Left=0.05
      Top=2.25
      Width=140
      Height=24
      bRelativeLeft=true
      bRelativeTop=true
      TopLeeway=20
      Images(0)=Texture2D'CastleUI.menus.T_CastleMenu2'
      Images(1)=Texture2D'CastleUI.menus.T_CastleMenu2'
      ImagesUVs(0)=(bCustomCoords=true,U=306,V=220,UL=310,VL=48)
      ImagesUVs(1)=(bCustomCoords=true,U=306,V=271,UL=310,VL=48)
   End Object
   MenuObjects.Add(OptionButton)

   Begin Object class=UDNMobileMenuLabel name=LabelOption
      Tag="LOption"
      Caption="Options"
      Height=32
      Width=120
      Left=.20
      Top=2.25
      TextFont=Font'EngineFonts.SmallFont'
      bRelativeLeft=true
      bRelativeTop=true
      CaptionColor=(R=1.0,G=1.0,B=1.0,A=1.0)
      BackgroundColor=(R=1.0,G=1.0,B=1.0,A=0.0)
   End Object
   MenuObjects.Add(LabelOption)
   
   Begin Object Class=MobileMenuButton Name=HighScoresButton
      Tag="HIGHSCORES"
      Left=0.05
      Top=3.0
      Width=140
      Height=24
      bRelativeLeft=true
      bRelativeTop=true
      TopLeeway=20
      Images(0)=Texture2D'CastleUI.menus.T_CastleMenu2'
      Images(1)=Texture2D'CastleUI.menus.T_CastleMenu2'
      ImagesUVs(0)=(bCustomCoords=true,U=306,V=220,UL=310,VL=48)
      ImagesUVs(1)=(bCustomCoords=true,U=306,V=271,UL=310,VL=48)
   End Object
   MenuObjects.Add(HighScoresButton)

   Begin Object class=UDNMobileMenuLabel name=LabelScores
      Tag="LHighscores"
      Caption="High Scores"
      Height=32
      Width=120
      Left=.20
      Top=3.0
      TextFont=Font'EngineFonts.SmallFont'
      bRelativeLeft=true
      bRelativeTop=true
      CaptionColor=(R=1.0,G=1.0,B=1.0,A=1.0)
      BackgroundColor=(R=1.0,G=1.0,B=1.0,A=0.0)
   End Object
   MenuObjects.Add(LabelScores)

   HSMenuClass = class'ShooterMenu_HighScores'
}

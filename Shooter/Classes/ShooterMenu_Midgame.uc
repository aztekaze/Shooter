class ShooterMenu_Midgame extends ShooterMenu_Base;

defaultproperties
{
   Begin Object Class=MobileMenuImage Name=Background
      Tag="Background"
      Left=0
      Top=0
      Width=1.0
      Height=.5
      bRelativeWidth=true
      bRelativeHeight=true
      Image=Texture2D'CastleUI.menus.T_CastleMenu2'
      ImageDrawStyle=IDS_Stretched
      ImageUVs=(bCustomCoords=true,U=0,V=30,UL=1024,VL=180)
   End Object
   MenuObjects.Add(Background)

   Begin Object Class=MobileMenuButton Name=MenuButton
      Tag="MENU"
      Left=0.85
      Top=0.125
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
   MenuObjects.Add(MenuButton)

   Begin Object class=UDNMobileMenuLabel name=LabelMenu
      Tag="Title"
      Caption="Menu"
      Height=32
      Width=80
      Left=.75
      Top=.125
      TextFont=Font'EngineFonts.SmallFont'
      bRelativeLeft=true
      bRelativeTop=true
      CaptionColor=(R=1.0,G=1.0,B=1.0,A=1.0)
      BackgroundColor=(R=1.0,G=1.0,B=1.0,A=0.0)
   End Object
   MenuObjects.Add(LabelMenu)
   

}
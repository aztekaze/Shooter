class UDNMobileMenuLabel extends MobileMenuObject;


/** The 2 images that make up the label. [0] = the untouched, [1] = touched */
var Texture2D Image;

/** The UV Coordinates for the images. [0] = the untouched, [1] = touched */
var UVCoords ImageUVs;

/** Holds the color override for the image */
var LinearColor ImageColor;

/** Localizable caption for the label */
var string Caption;

/** Holds the color for the caption */
var LinearColor CaptionColor;

/** Holds the font that will be used to draw the text */
var font TextFont;

/** If TRUE, center the text in the label. Otherwise, left align it. */
var bool bCenterText;

/** If TRUE, the label text will not wrap */
var bool bClipText;

/** Number of pixels to pad text when not centering text */
var float TextPadding;

/** Colors to use to draw the background of the label. Used if no texture is specified */
var LinearColor BackgroundColor;

/** Colors to use to draw the borders of the label. Used if no texture is specified. */
var LinearColor BorderColor;

/** Widths of the four borders. (Order: Top, Right, Bottom, Left) */
var float BorderWidth[4];

/** If TRUE, use DrawTileStretched() to draw the label image. Otherwise, use DrawTile(). */
var bool bStretchBackground;


/**
 * Initialize label - Setup image coords
 */
function InitMenuObject(MobilePlayerInput PlayerInput, MobileMenuScene Scene, int ScreenWidth, int ScreenHeight)
{   
   Super.InitMenuObject(PlayerInput, Scene, ScreenWidth, ScreenHeight);

   ImageUVs.U = 0.0f;
   ImageUVs.V = 0.0f;
   ImageUVs.UL = Image.SizeX;
   ImageUVs.VL = Image.SizeY;

   /*
   //No custom coords, set to full size of image
   for (i=0;i<2;i++)
   {
      if (!ImagesUVs[i].bCustomCoords && Images[i] != none)
      {
         ImagesUVs[i].U = 0.0f;
         ImagesUVs[i].V = 0.0f;
         ImagesUVs[i].UL = Images[i].SizeX;
         ImagesUVs[i].VL = Images[i].SizeY;
      }
   }
   */
}


/**
 * Render the widget
 */
function RenderObject(canvas Canvas)
{
   local LinearColor DrawColor;
   
   //If there is an image set, draw it
   if(Image != none)
   {   
      //Set up Canvas for drawing the background image
      Canvas.SetPos(OwnerScene.Left + Left - Canvas.OrgX, OwnerScene.Top + Top - Canvas.OrgY);
      Drawcolor = ImageColor;
      Drawcolor.A *= Opacity * OwnerScene.Opacity;
      
      //Draw background image stretched
      if(bStretchBackground)
      {
         Canvas.DrawTileStretched(Image, Width, Height,ImageUVs.U, ImageUVs.V, ImageUVs.UL, ImageUVs.VL, DrawColor, true, true);
      }
      //Draw background image scaled
      else
      {
         Canvas.DrawTile(Image, Width, Height,ImageUVs.U, ImageUVs.V, ImageUVs.UL, ImageUVs.VL, DrawColor, true);
      }
   }
   //No image set, draw simple rect background
   else
   {
      //Set up Canvas for drawing the background rect
      Canvas.SetPos(OwnerScene.Left + Left - Canvas.OrgX, OwnerScene.Top + Top - Canvas.OrgY);
      Canvas.DrawColor.R = byte(BackgroundColor.R * 255.0);
      Canvas.DrawColor.G = byte(BackgroundColor.G * 255.0);
      Canvas.DrawColor.B = byte(BackgroundColor.B * 255.0);
      Canvas.DrawColor.A = byte(BackgroundColor.A * 255.0);
      Canvas.DrawRect(Width, Height);

      //Draw border
      DrawBorder(Canvas);
   }

   //Draw caption text
   RenderCaption(Canvas);
}

/**
 * Draw the label's border
 *
 * @param Canvas - Canvas object used for drawing
 */
function DrawBorder(Canvas Canvas)
{
   //Draw top border
   if(BorderWidth[0] > 0)
   {
      Canvas.SetPos(Left - Canvas.OrgX, Top - Canvas.OrgY);
      Canvas.DrawColor.R = byte(BorderColor.R * 255.0);
      Canvas.DrawColor.G = byte(BorderColor.G * 255.0);
      Canvas.DrawColor.B = byte(BorderColor.B * 255.0);
      Canvas.DrawColor.A = byte(BorderColor.A * 255.0);
      Canvas.DrawRect(Width, BorderWidth[0]);
   }
   
   //Draw right border
   if(BorderWidth[1] > 0)
   {
      Canvas.SetPos(Left + Width - 1 - Canvas.OrgX, Top + Height - 1 - Canvas.OrgY);
      Canvas.DrawColor.R = byte(BorderColor.R * 255.0);
      Canvas.DrawColor.G = byte(BorderColor.G * 255.0);
      Canvas.DrawColor.B = byte(BorderColor.B * 255.0);
      Canvas.DrawColor.A = byte(BorderColor.A * 255.0);
      Canvas.DrawRect(BorderWidth[1], Height);
   }
   
   //Draw bottom border
   if(BorderWidth[2] > 0)
   {
      Canvas.SetPos(Left - Canvas.OrgX, Top + Height - 1 - Canvas.OrgY);
      Canvas.DrawColor.R = byte(BorderColor.R * 255.0);
      Canvas.DrawColor.G = byte(BorderColor.G * 255.0);
      Canvas.DrawColor.B = byte(BorderColor.B * 255.0);
      Canvas.DrawColor.A = byte(BorderColor.A * 255.0);
      Canvas.DrawRect(Width, BorderWidth[2]);
   }
   
   //Draw left border
   if(BorderWidth[3] > 0)
   {
      Canvas.SetPos(Left - Canvas.OrgX, Top - Canvas.OrgY);
      Canvas.DrawColor.R = byte(BorderColor.R * 255.0);
      Canvas.DrawColor.G = byte(BorderColor.G * 255.0);
      Canvas.DrawColor.B = byte(BorderColor.B * 255.0);
      Canvas.DrawColor.A = byte(BorderColor.A * 255.0);
      Canvas.DrawRect(BorderWidth[3], Height);
   }
}

/**
 * Draw the label's text
 *
 * @param Canvas - Canvas object used for drawing
 */
function RenderCaption(canvas Canvas)
{
   local float X,Y,UL,VL;
   local FontRenderInfo FRI;

   //Only draw if some text is set
   if (Caption != "")
   {
      Canvas.Font = TextFont;
      Canvas.TextSize(Caption,UL,VL);

      //Center text if necessary, left-align otherwise
      if(bCenterText)
      {
         X = Left + (Width / 2) - (UL/2);
         Y = Top + (Height /2) - (VL/2);
      }
      else
      {
         X = Left + 5;
         Y = Top + (Height /2) - (VL/2);
      }

      //Set up Canvas for drawing caption
      Canvas.SetPos(OwnerScene.Left + X - Canvas.OrgX, OwnerScene.Top + Y - Canvas.OrgY);
      Canvas.DrawColor.R = byte(CaptionColor.R * 255.0);
      Canvas.DrawColor.G = byte(CaptionColor.G * 255.0);
      Canvas.DrawColor.B = byte(CaptionColor.B * 255.0);
      Canvas.DrawColor.A = byte(CaptionColor.A * 255.0);

      //Draw text - clip if desired
      FRI.bClipText = bClipText;
      Canvas.DrawText(Caption, false, 1.0, 1.0, FRI);
   }
}

defaultproperties
{
   ImageColor=(r=1.0,g=1.0,b=1.0,a=1.0)
   CaptionColor=(r=0.0,g=0.0,b=0.0,a=1.0)
   
   bIsActive=false
   bCenterText=false
   bStretchBackground=true
   
   BorderWidth(0)=0
   BorderWidth(1)=0
   BorderWidth(2)=0
   BorderWidth(3)=0
}
import java.applet.*;
import java.awt.*;
import javax.swing.*;
import java.awt.image.*;
import java.awt.event.*;

public class Mandelbrot extends Applet implements MouseListener, KeyListener {

  /* Global variables (necessary) */
  int width, height;
  double halfHeight = 1;
  double leftWidth = 1.5;
  double totalWidth;
  double centerX = 0;
  double centerY = 0;

  double Zx;
  double Zy;
  double Cx;
  double Cy;
  double Z0x;
  double Z0y;
  double stepX;
  double stepY;

  int[][] colorTable;
  int nbColors;
  /* Limit and upper limit */
  int kMax = 200;
  int kLimit = 1000;
  BufferedImage img; /* the image */

  /* timer */
  private long start;
  private long end;
  /* Pre computing some value */
  double invLog = 1 /Math.log(2);  
  int blackRGB = Color.black.getRGB();

  /* Initialization */
  public void init() {
    width = getSize().width;
    height = getSize().height;
    double rightWidth = 0.5;
    totalWidth = leftWidth + rightWidth;

    Color darkgrey = new Color(60,60,60);
    setBackground(darkgrey);
    createColorTable();
    img = new BufferedImage(width, height, BufferedImage.TYPE_4BYTE_ABGR);
    addMouseListener(this); 
    addKeyListener(this); 


  }

  /* Create a color table */
  void createColorTable()
  {  
    nbColors = 4;
    colorTable = new int[nbColors][3];

    /* blue */
    colorTable[0][0] = 25;
    colorTable[0][1] = 25;
    colorTable[0][2] = 112;

    colorTable[1][0] = 178;
    colorTable[1][1] = 223;
    colorTable[1][2] = 238;

    /* yellow - orange */
    colorTable[2][0] = 255;
    colorTable[2][1] = 255;
    colorTable[2][2] = 0;

    colorTable[3][0] = 238;
    colorTable[3][1] = 118;
    colorTable[3][2] = 0;
  }

  /* Set the color of iteration k */
  int getColorIteration(double norm, int k)
  {
    /* Anti aliasing */
    double aliasing = 0.5*Math.log(norm);
    double ln = Math.log(aliasing)* invLog ;
    aliasing = k - ln;
    if (aliasing < 0)
      aliasing = -aliasing;

    float period = 0.5f;

    float coef = (float) aliasing / (period*kMax);

    /* Periodic colors */
    if (coef > 1.f)
      coef -= 1.f;
    float coef2;
    float r;
    float g;
    float b;

    /* There are nbColors colors only
     * Other colors are obtained with interpolation */
    coef *= (float) nbColors;
    int i = (int) Math.floor(coef);
    coef2 = coef-i;
    int j = i < nbColors-1 ? i+1 : i;

    /* Linear interpolation between color i and j */
    r = colorTable[i][0]*(1.f-coef2) + colorTable[j][0]*coef2 ;
    g = colorTable[i][1]*(1.f-coef2) + colorTable[j][1]*coef2 ;
    b = colorTable[i][2]*(1.f-coef2) + colorTable[j][2]*coef2 ;
    Color c = new Color((int) r, (int) g, (int) b);
    int colorRGB = c.getRGB();
    return colorRGB;
  }

  /* Paint a chunk of the image */
  void paintChunk(int i, int j, int chunkSize)
  {
    int colorChunk = img.getRGB(i,j);

    colorChunk = getPixelColor(i,j);
    int xLimit = i+chunkSize;
    if (xLimit > width)
      xLimit = width;
    int yLimit = j+chunkSize;
    if (yLimit > height)
      yLimit = height;

    for (int k = i; k < xLimit; k ++)
    {
      for (int l = j; l < yLimit; l ++)
        img.setRGB(k,l, colorChunk);
    }
  }

  public void paint( Graphics g ) {
    start = System.currentTimeMillis();
    Graphics2D g2 = (Graphics2D) g;

    /* Z0 is the upper-left corner */
    Z0x = centerX-leftWidth;
    Z0y = centerY + halfHeight;
    stepX = totalWidth/(width-1);
    stepY = -2*halfHeight/(height-1);
    stepX *= height/width;

    /* Successive refinement for painting */
    int chunkSize = 32; 
    Graphics2D gImg;
    gImg = img.createGraphics();
    /* The first pixel of a chunk has already been done in the first pass */
    boolean alreadyDone;
    while(chunkSize > 0)
    {
      for (int i = 0; i < width; i += chunkSize)
        for (int j = 0; j < height; j += chunkSize)
        {
          alreadyDone = chunkSize < 32 && i % (2*chunkSize) == 0;
          alreadyDone = alreadyDone && j % (2*chunkSize) == 0;
          if (!alreadyDone)
            paintChunk(i,j,chunkSize);  
        }
      g2.drawImage(img, null, 0, 0);
      chunkSize /= 2;

      //long t0=System.currentTimeMillis();
      //long t1;
      //do{
      //  t1=System.currentTimeMillis();
      //}
      //while (t1-t0<1000);
    }


    end = System.currentTimeMillis();
    long delta = end - start;
    //System.out.println("duree "+delta);
  }

  /* Set the color of the pixel (i,j) in the buffered image */
  int getPixelColor(int i, int j)
  {
    int colorRGB;
    int j0;
    boolean isInside;
    double Ztmp;
    double norm = 1;

    Cx = Z0x + stepX*i;
    Cy = Z0y + stepY*j;
    Zx = Cx;
    Zy = Cy;

    isInside = true;
    int k = 0;
    while (k < kMax)
    {
      norm = Zx*Zx+Zy*Zy;
      if (norm > 4)
      {
        isInside = false;
        break;
      }
      /* Zn+1 = Zn^2 + c */
      Ztmp = Zx*Zx - Zy*Zy + Cx ;
      Zy = 2*Zx*Zy + Cy;

      Zx = Ztmp;
      k++;
    }
    /* If the point is approximatively outside, set a color */
    if (isInside)
      return blackRGB;
    else
    {
      colorRGB = getColorIteration(norm,k);
      return colorRGB;
    }
  }

  /* Zoom function */
  void zoomIn(int pixelX,int pixelY) {
    totalWidth /= 2;
    /* Now leftWidth = rightWidth */
    leftWidth = 0.5*totalWidth;
    halfHeight /= 2;
    centerX = Z0x + stepX*pixelX; 
    centerY = Z0y + stepY*pixelY; 
    repaint();
  }

  /* Zoom function */
  void zoomOut(int pixelX,int pixelY) {
    totalWidth *= 2;
    leftWidth = 0.5*totalWidth;
    halfHeight *= 2;
    centerX = Z0x + stepX*pixelX; 
    centerY = Z0y + stepY*pixelY; 
    repaint();
  }


  /* Managing the mouse */
  public void mouseClicked (MouseEvent e) {
    /* Array starts at 0 */
    int xpos = e.getX()-1; 
    int ypos = e.getY()-1;
    /* Left click */
    if (e.getButton() == MouseEvent.BUTTON1) 
      zoomIn(xpos,ypos);
    else if (e.getButton() == MouseEvent.BUTTON3) 
      zoomOut(xpos,ypos);
  }
  public void mouseEntered (MouseEvent me) {} 
  public void mousePressed (MouseEvent me) {} 
  public void mouseReleased (MouseEvent me) {}  
  public void mouseExited (MouseEvent me) {}  

  /* Managing the mouse */
  public void keyPressed( KeyEvent e ) { }
  public void keyReleased( KeyEvent e ) { }
  public void keyTyped( KeyEvent e ) {
    char c = e.getKeyChar();
    if ( c == '+' && kMax < kLimit) {
      kMax += 100;
      repaint();
    }
    else if ( c == '-' && kMax > 200) {
      kMax -= 100;
      repaint();
    }
  }

  public static void main(String[] args) { }
}

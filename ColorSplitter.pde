boolean ready = true;
GUI gui;

void setup ()
{
  size(100, 100);
  frameRate(1);
  surface.setVisible(false);
  noLoop();
  
  gui = new GUI();
  while (!ready)
  {
    // hold
  }
}

void doit (File inputFolder, File outputFolder, Color primaryColor, Color secondaryColor, Color outlineColor)
{
  File[] inputList = inputFolder.listFiles();
  for (File inputFile : inputList)
  {
    PImage originalImage = loadImage(inputFile.getAbsolutePath());
    originalImage.loadPixels();
    PImage primaryImage = createImage(originalImage.width, originalImage.height, ARGB);
    PImage secondaryImage = createImage(originalImage.width, originalImage.height, ARGB);
    PImage outlineImage = createImage(originalImage.width, originalImage.height, ARGB);
    
    for (int x = 0; x < originalImage.width; x++)
    {
      for (int y = 0; y < originalImage.height; y++)
      {
        if (colorColorEquals(originalImage.pixels[y*originalImage.width+x], primaryColor))
        {
          primaryImage.pixels[y*originalImage.width+x] = color(255);
        }
        if (colorColorEquals(originalImage.pixels[y*originalImage.width+x], secondaryColor))
        {
          secondaryImage.pixels[y*originalImage.width+x] = color(255);
        }
        if (colorColorEquals(originalImage.pixels[y*originalImage.width+x], outlineColor))
        {
          outlineImage.pixels[y*originalImage.width+x] = color(255);
        }
      }
    }
    
    String[] originalName = inputFile.getName().split("_");
    primaryImage.save(outputFolder.getAbsolutePath() + "/" + originalName[0] + "Primary_" + originalName[1]);
    secondaryImage.save(outputFolder.getAbsolutePath() + "/" + originalName[0] + "Secondary_" + originalName[1]);
    outlineImage.save(outputFolder.getAbsolutePath() + "/" + originalName[0] + "Outline_" + originalName[1]);
  }
  
  JOptionPane.showMessageDialog(frame, "DOOONNNEEEE!!!!1!!!11!!", "omgomgomgomg", JOptionPane.INFORMATION_MESSAGE);
}

boolean colorColorEquals (color c1, Color c2)
{
  return red(c1) == c2.getRed() && green(c1) == c2.getGreen() && blue(c1) == c2.getBlue() && alpha(c1) == c2.getAlpha();
}

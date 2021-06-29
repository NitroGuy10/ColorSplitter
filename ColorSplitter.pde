boolean ready = false;
GUI gui;
ArrayList<SplitSetting> splits;
File inputFolder;
File outputFolder;

void setup ()
{
  size(100, 100);
  frameRate(1);
  surface.setVisible(false);
  noLoop();

  splits = new ArrayList();
  gui = new GUI();
  while (!ready)
  {
    // hold
  }
}

void doit ()
{
  File[] inputList = inputFolder.listFiles();
  for (File inputFile : inputList)
  {
    PImage originalImage = loadImage(inputFile.getAbsolutePath());
    originalImage.loadPixels();

    for (SplitSetting setting : splits)
    {
      PImage splitImage = createImage(originalImage.width, originalImage.height, ARGB);

      for (int x = 0; x < originalImage.width; x++)
      {
        for (int y = 0; y < originalImage.height; y++)
        {
          if (colorColorEquals(originalImage.pixels[y*originalImage.width+x], setting.getColor()))
          {
            splitImage.pixels[y*originalImage.width+x] = color(255);
          }
        }
      }

      String originalName = inputFile.getName();
      if (originalName.matches(".*_[0-9]+.*"))
      {
        splitImage.save(outputFolder.getAbsolutePath() + "/" + originalName.substring(0, originalName.lastIndexOf("_")) + setting.getName() + originalName.substring(originalName.lastIndexOf("_")));
      }
      else
      {
        splitImage.save(outputFolder.getAbsolutePath() + "/" + originalName + setting.getName());
      }
    }
  }

  JOptionPane.showMessageDialog(frame, "All Done!", "Hooray!", JOptionPane.INFORMATION_MESSAGE);
}

boolean colorColorEquals (color c1, Color c2)
{
  return red(c1) == c2.getRed() && green(c1) == c2.getGreen() && blue(c1) == c2.getBlue() && alpha(c1) == c2.getAlpha();
}

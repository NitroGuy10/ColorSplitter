import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;

public class ColorSplitter
{
	static GUI gui;
	static ArrayList<SplitSetting> splits;
	static File inputFolder;
	static File outputFolder;

	public static void main (String[] args)
	{
		splits = new ArrayList<>();
		gui = new GUI();
	}

	public static void doIt ()
	{
		File[] inputList = inputFolder.listFiles();
		for (File inputFile : inputList)
		{
			BufferedImage originalImage;
			try
			{
				originalImage = ImageIO.read(inputFile);
			}
			catch (IOException e)
			{
				gui.errorReading(inputFile.getName());
				return;
			}

			for (SplitSetting setting : splits)
			{
				BufferedImage splitImage = new BufferedImage(originalImage.getWidth(), originalImage.getHeight(), BufferedImage.TYPE_INT_ARGB);

				for (int x = 0; x < originalImage.getWidth(); x++)
				{
					for (int y = 0; y < originalImage.getHeight(); y++)
					{
						if (originalImage.getRGB(x, y) == setting.getColor().getRGB())
						{
							splitImage.setRGB(x, y, Color.WHITE.getRGB());
						}
					}
				}

				String originalName = inputFile.getName();
				try
				{
					if (originalName.matches(".*_[0-9]+.*"))
					{
						ImageIO.write(splitImage, "png", new File(outputFolder.getAbsolutePath() + "/" + originalName.substring(0, originalName.lastIndexOf("_")) + setting.getName() + originalName.substring(originalName.lastIndexOf("_"))));
					}
					else
					{
						ImageIO.write(splitImage, "png", new File(outputFolder.getAbsolutePath() + "/" + originalName + setting.getName()));
					}
				}
				catch (IOException e)
				{
					gui.errorWriting();
					return;
				}
			}
		}
		gui.allDone();
	}
}

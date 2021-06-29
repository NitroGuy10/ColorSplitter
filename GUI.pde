import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.event.MouseEvent;
import java.io.File;

public class GUI implements ActionListener
{
  JLabel inputLabel;
  JLabel outputLabel;
  JLabel primaryLabel;
  Color primaryColor = Color.black;
  JLabel secondaryLabel;
  Color secondaryColor = Color.black;
  JLabel outlineLabel;
  Color outlineColor = Color.black;
  File inputFolder;
  File outputFolder;

  GUI ()
  {
    try
    {
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    }
    catch (Exception e)
    {
      
    }
    
    JFrame frame = new JFrame("ColorSplitter");
    frame.setSize(900, 150);

    JPanel panel = new JPanel();

    JButton inputButton = new JButton("Choose Input Folder");
    inputButton.setActionCommand("choose input folder");
    inputButton.addActionListener(this);
    panel.add(inputButton);
    
    inputLabel = new JLabel("No folder chosen");
    panel.add(inputLabel);
    
    
    JButton primaryButton = new JButton("Choose Primary Color");
    primaryButton.setActionCommand("choose primary");
    primaryButton.addActionListener(this);
    panel.add(primaryButton);
    
    primaryLabel = new JLabel("\u2588\u2588\u2588\u2588\u2588");
    panel.add(primaryLabel);
    
    
    JButton secondaryButton = new JButton("Choose Secondary Color");
    secondaryButton.setActionCommand("choose secondary");
    secondaryButton.addActionListener(this);
    panel.add(secondaryButton);
    
    secondaryLabel = new JLabel("\u2588\u2588\u2588\u2588\u2588");
    panel.add(secondaryLabel);


    JButton outlineButton = new JButton("Choose Outline Color");
    outlineButton.setActionCommand("choose outline");
    outlineButton.addActionListener(this);
    panel.add(outlineButton);
    
    outlineLabel = new JLabel("\u2588\u2588\u2588\u2588\u2588");
    panel.add(outlineLabel);

    
    JButton outputButton = new JButton("Choose Output Folder");
    outputButton.setActionCommand("choose output folder");
    outputButton.addActionListener(this);
    panel.add(outputButton);
    
    outputLabel = new JLabel("No folder chosen");
    panel.add(outputLabel);
    
    
    JButton doitButton = new JButton("DO IT!!!!!!!!!");
    doitButton.setBackground(Color.red);
    doitButton.setActionCommand("do it");
    doitButton.addActionListener(this);
    panel.add(doitButton);


    frame.add(panel);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setVisible(true);

    ready = true;
  }

  @Override
    public void actionPerformed (ActionEvent e)
  {
    if (e.getActionCommand().equals("do it"))
    {
      if (inputFolder == null || outputFolder == null)
      {
        JOptionPane.showMessageDialog(frame, "Choose a folder, dingus.", "SMH my head", JOptionPane.ERROR_MESSAGE);
      }
      else
      {
        JOptionPane.showMessageDialog(frame, "Doing it!!!!!! :DDDDD", "Lesss gooooo", JOptionPane.INFORMATION_MESSAGE);
        doit(inputFolder, outputFolder, primaryColor, secondaryColor, outlineColor);
      }
    }
    else if (e.getActionCommand().equals("choose input folder"))
    {
      JFileChooser fileChooser = new JFileChooser();
      fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
      int option = fileChooser.showOpenDialog(frame);
      if (option == JFileChooser.APPROVE_OPTION)
      {
        inputFolder = fileChooser.getSelectedFile();
        inputLabel.setText(inputFolder.getAbsolutePath());
      }
    }
    else if (e.getActionCommand().equals("choose output folder"))
    {
      JFileChooser fileChooser = new JFileChooser();
      fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
      int option = fileChooser.showSaveDialog(frame);
      if (option == JFileChooser.APPROVE_OPTION)
      {
        outputFolder = fileChooser.getSelectedFile();
        outputLabel.setText(outputFolder.getAbsolutePath());
      }
    }
    else if (e.getActionCommand().equals("choose primary"))
    {
      Color newColor = JColorChooser.showDialog(frame, "Choose Primary Color", primaryColor);
      if (newColor != null)
      {
        primaryColor = newColor;
        primaryLabel.setForeground(newColor);
      }
    }
    else if (e.getActionCommand().equals("choose secondary"))
    {
      Color newColor = JColorChooser.showDialog(frame, "Choose Secondary Color", secondaryColor);
      if (newColor != null)
      {
        secondaryColor = newColor;
        secondaryLabel.setForeground(newColor);
      }
    }
    else if (e.getActionCommand().equals("choose outline"))
    {
      Color newColor = JColorChooser.showDialog(frame, "Choose Outline Color", outlineColor);
      if (newColor != null)
      {
        outlineColor = newColor;
        outlineLabel.setForeground(newColor);
      }
    }
  }
}

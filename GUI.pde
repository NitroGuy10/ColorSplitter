import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.event.MouseEvent;
import java.io.File;

public class GUI implements ActionListener
{
  public static final int MAX_SPLITS = 20;
  
  JLabel inputLabel;
  JLabel outputLabel;
  JLabel primaryLabel;
  Color primaryColor = Color.black;
  JLabel secondaryLabel;
  Color secondaryColor = Color.black;
  JLabel outlineLabel;
  Color outlineColor = Color.black;
  JPanel centerPanel;
  JButton newSplitButton;
  

  GUI ()
  {
    try
    {
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    }
    catch (Exception e)
    {
      
    }
    
    
    JFrame frame = new JFrame("NitroGuy's ColorSplitter");
    frame.setSize(700, 500);
    frame.setPreferredSize(frame.getSize());

    JPanel panel = new JPanel(new BorderLayout());

    JPanel topPanel = new JPanel(new FlowLayout());
    
    JButton inputButton = new JButton("Choose Input Folder");
    inputButton.setActionCommand("choose input folder");
    inputButton.addActionListener(this);
    topPanel.add(inputButton);
    
    inputLabel = new JLabel("No folder chosen");
    topPanel.add(inputLabel);
    
    panel.add(topPanel, BorderLayout.NORTH);
    
    centerPanel = new JPanel(new GridLayout(MAX_SPLITS + 1, 1));
    JScrollPane scrollPane = new JScrollPane(centerPanel, JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
    scrollPane.getVerticalScrollBar().setUnitIncrement(5);
    
    newSplitButton = new JButton(" + New Color Split + ");
    newSplitButton.setActionCommand("new split");
    newSplitButton.addActionListener(this);
    centerPanel.add(newSplitButton);
    
    panel.add(scrollPane, BorderLayout.CENTER);

    
    JPanel bottomPanel = new JPanel();
    
    JButton outputButton = new JButton("Choose Output Folder");
    outputButton.setActionCommand("choose output folder");
    outputButton.addActionListener(this);
    bottomPanel.add(outputButton);
    
    outputLabel = new JLabel("No folder chosen");
    bottomPanel.add(outputLabel);
    
    
    JButton doitButton = new JButton("DO IT!!!!!!!!!");
    doitButton.setBackground(Color.red);
    doitButton.setActionCommand("do it");
    doitButton.addActionListener(this);
    bottomPanel.add(doitButton);
    
    /*
    JLabel siteLabel = new JLabel("<html><a href=\"https://nitroguy10.github.io/\">website</a></html>");
    bottomPanel.add(siteLabel);
    */
    
    panel.add(bottomPanel, BorderLayout.SOUTH);


    frame.add(panel);
    frame.pack();
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
      if (inputFolder != null)
      {
        fileChooser.setCurrentDirectory(inputFolder);
      }
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
      if (outputFolder != null)
      {
        fileChooser.setCurrentDirectory(outputFolder);
      }
      fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
      int option = fileChooser.showSaveDialog(frame);
      if (option == JFileChooser.APPROVE_OPTION)
      {
        outputFolder = fileChooser.getSelectedFile();
        outputLabel.setText(outputFolder.getAbsolutePath());
      }
    }
    else if (e.getActionCommand().equals("new split"))
    {
      centerPanel.remove(newSplitButton);
      SplitSetting newSplit = new SplitSetting();
      splits.add(newSplit);
      centerPanel.add(newSplit);
      if (splits.size() < MAX_SPLITS)
      {
        centerPanel.add(newSplitButton);
      }
      centerPanel.revalidate();
    }
  }
  
  public void removeSplitSetting (SplitSetting ss)
  {
    centerPanel.remove(ss);
    if (splits.size() == MAX_SPLITS)
    {
      centerPanel.add(newSplitButton);
    }
    splits.remove(splits.indexOf(ss));
    newSplitButton.revalidate();
    centerPanel.revalidate();
  }
}

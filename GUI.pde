import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.event.MouseEvent;
import java.io.File;
import java.net.URI;
import java.util.prefs.Preferences;
import java.util.Scanner;

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
    
    JPanel masterPanel = new JPanel(new BorderLayout());

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
    
    
    panel.add(bottomPanel, BorderLayout.SOUTH);
    
    
    JMenuBar menuBar = new JMenuBar();
    
    JMenu fileMenu = new JMenu("Presets");
    menuBar.add(fileMenu);
    
    JMenuItem newMenuItem = new JMenuItem("New");
    newMenuItem.setActionCommand("new");
    newMenuItem.addActionListener(this);
    fileMenu.add(newMenuItem);
    
    fileMenu.addSeparator();
    
    JMenuItem loadMenuItem = new JMenuItem("Load Preset...");
    loadMenuItem.setActionCommand("load");
    loadMenuItem.addActionListener(this);
    fileMenu.add(loadMenuItem);
    
    JMenuItem saveMenuItem = new JMenuItem("Save Preset As...");
    saveMenuItem.setActionCommand("save");
    saveMenuItem.addActionListener(this);
    fileMenu.add(saveMenuItem);
    
    JMenuItem deleteMenuItem = new JMenuItem("Delete Preset...");
    deleteMenuItem.setActionCommand("delete");
    deleteMenuItem.addActionListener(this);
    fileMenu.add(deleteMenuItem);
    
    fileMenu.addSeparator();
    
    JMenuItem importMenuItem = new JMenuItem("Import Preset...");
    importMenuItem.setActionCommand("import");
    importMenuItem.addActionListener(this);
    fileMenu.add(importMenuItem);
    
    JMenuItem exportMenuItem = new JMenuItem("Export Preset...");
    exportMenuItem.setActionCommand("export");
    exportMenuItem.addActionListener(this);
    fileMenu.add(exportMenuItem);
    
    fileMenu.addSeparator();
    
    JMenuItem defaultMenuItem = new JMenuItem("Set Current State As Default");
    defaultMenuItem.setActionCommand("set default");
    defaultMenuItem.addActionListener(this);
    fileMenu.add(defaultMenuItem);
    
    
    JMenu aboutMenu = new JMenu("About");
    menuBar.add(aboutMenu);
    
    JMenuItem readmeMenuItem = new JMenuItem("View Readme");
    readmeMenuItem.setActionCommand("readme");
    readmeMenuItem.addActionListener(this);
    aboutMenu.add(readmeMenuItem);
    
    JMenuItem siteMenuItem = new JMenuItem("nitroguy10.github.io");
    siteMenuItem.setActionCommand("site");
    siteMenuItem.addActionListener(this);
    aboutMenu.add(siteMenuItem);
    

    masterPanel.add(menuBar, BorderLayout.NORTH);
    masterPanel.add(panel, BorderLayout.CENTER);
    frame.add(masterPanel);
    frame.pack();
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setVisible(true);
    
    Preferences prefs = Preferences.userNodeForPackage(ColorSplitter.class);
    loadPreset(prefs.get("(default)", ""));

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
        JOptionPane.showMessageDialog(frame, "Color splitting in progress! Now wait for the \"done\" message. :)", "Doing it!", JOptionPane.INFORMATION_MESSAGE);
        doit();
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
    else if (e.getActionCommand().equals("new"))
    {
      clearSettings();
    }
    else if (e.getActionCommand().equals("readme"))
    {
      try
      {
        Desktop.getDesktop().browse(new URI("https://github.com/NitroGuy10/ColorSplitter#readme"));
      }
      catch (Exception ex) {}
    }
    else if (e.getActionCommand().equals("site"))
    {
      try
      {
        Desktop.getDesktop().browse(new URI("https://nitroguy10.github.io/"));
      }
      catch (Exception ex) {}
    }
    else if (e.getActionCommand().equals("save"))
    {
      String presetName = (String) JOptionPane.showInputDialog(frame, "Choose Preset Name", "Save Preset As...", JOptionPane.PLAIN_MESSAGE);
      if (presetName != null)
      {
        String saveString = "";
        for (SplitSetting setting : splits)
        {
          saveString += setting.toConfig() + "\n";
        }
        Preferences prefs = Preferences.userNodeForPackage(ColorSplitter.class);
        prefs.put(presetName, saveString);
      }
    }
    else if (e.getActionCommand().equals("load"))
    {
      Preferences prefs = Preferences.userNodeForPackage(ColorSplitter.class);
      String presetName = "";
      try
      {
        presetName = (String) JOptionPane.showInputDialog(frame, "Choose Preset", "Load Preset...", JOptionPane.PLAIN_MESSAGE, null, prefs.keys(), "");
      }
      catch (Exception ex)
      {
        
      }
      if (presetName != null)
      {
        loadPreset(prefs.get(presetName, ""));
      }
    }
    else if (e.getActionCommand().equals("delete"))
    {
      Preferences prefs = Preferences.userNodeForPackage(ColorSplitter.class);
      String presetName = "";
      try
      {
        presetName = (String) JOptionPane.showInputDialog(frame, "Choose Preset", "Delete Preset...", JOptionPane.PLAIN_MESSAGE, null, prefs.keys(), "");
      }
      catch (Exception ex)
      {
        
      }
      if (presetName != null)
      {
        prefs.remove(presetName);
      }
    }
    else if (e.getActionCommand().equals("export"))
    {
      String saveString = "";
      for (SplitSetting setting : splits)
      {
        saveString += setting.toConfig() + "\n";
      }
      
      JFileChooser fileChooser = new JFileChooser();
      int option = fileChooser.showSaveDialog(frame);
      if (option == JFileChooser.APPROVE_OPTION)
      {
        try
        {
          File presetFile = fileChooser.getSelectedFile();
          presetFile = new File(presetFile.getAbsolutePath() + ".cspreset");
          PrintWriter writer = new PrintWriter(presetFile);
          writer.write(saveString);
          writer.close();
        }
        catch (Exception ex)
        {
          JOptionPane.showMessageDialog(frame, "Error exporting preset", "Darn", JOptionPane.ERROR_MESSAGE);
        }
      }
    }
    else if (e.getActionCommand().equals("import"))
    {
      JFileChooser fileChooser = new JFileChooser();
      int option = fileChooser.showOpenDialog(frame);
      if (option == JFileChooser.APPROVE_OPTION)
      {
        try
        {
          String config = "";
          Scanner reader = new Scanner(fileChooser.getSelectedFile());
          while (reader.hasNextLine())
          {
            config += reader.nextLine() + "\n";
          }
          reader.close();
          loadPreset(config);
        }
        catch (IOException ex)
        {
          JOptionPane.showMessageDialog(frame, "Error reading file", "Darn", JOptionPane.ERROR_MESSAGE);
        }
      }
    }
    else if (e.getActionCommand().equals("set default"))
    {
      String saveString = "";
      for (SplitSetting setting : splits)
      {
        saveString += setting.toConfig() + "\n";
      }
      Preferences prefs = Preferences.userNodeForPackage(ColorSplitter.class);
      prefs.put("(default)", saveString);
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
  
  public void clearSettings ()
  {
    for (SplitSetting setting : splits)
    {
      centerPanel.remove(setting);
    }
    if (splits.size() == MAX_SPLITS)
    {
      centerPanel.add(newSplitButton);
    }
    splits.clear();
    newSplitButton.revalidate();
    centerPanel.revalidate();
  }
  
  public void loadPreset (String config)
  {
    clearSettings();
    try
    {
      for (String setting : config.split("\n"))
      {
        if (!setting.isEmpty())
        {
          centerPanel.remove(newSplitButton);
          Scanner reader = new Scanner(setting);
          
          Color newColor = new Color(reader.nextInt(), reader.nextInt(), reader.nextInt(), reader.nextInt());
          
          SplitSetting newSplit = new SplitSetting(reader.nextLine().substring(1), newColor);
          splits.add(newSplit);
          centerPanel.add(newSplit);
          
          reader.close();
        }
      }
      if (splits.size() < MAX_SPLITS)
      {
        centerPanel.add(newSplitButton);
        newSplitButton.revalidate();
      }
      centerPanel.revalidate();
    }
    catch (Exception ex)
    {
      JOptionPane.showMessageDialog(frame, "Error reading preset", "Darn", JOptionPane.ERROR_MESSAGE);
    }
  }
}

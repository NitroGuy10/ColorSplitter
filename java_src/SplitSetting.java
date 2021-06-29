import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JColorChooser;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

@SuppressWarnings ("serial")
class SplitSetting extends JPanel implements ActionListener
{
	private JTextField textField;
	private JLabel colorLabel;
	private Color chosenColor;
	private GUI gui;

	public SplitSetting (String defaultName, Color defaultColor, GUI gui)
	{
		super(new GridLayout(1, 4));

		chosenColor = defaultColor;
		this.gui = gui;

		textField = new JTextField(defaultName);
		this.add(textField);

		JButton chooseColorButton = new JButton("Choose Color");
		chooseColorButton.setActionCommand("choose color");
		chooseColorButton.addActionListener(this);
		this.add(chooseColorButton);

		colorLabel = new JLabel("\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2588");
		colorLabel.setForeground(chosenColor);
		this.add(colorLabel);

		JButton removeButton = new JButton("Remove");
		removeButton.setActionCommand("remove");
		removeButton.addActionListener(this);
		this.add(removeButton);
	}

	public SplitSetting (GUI gui)
	{
		this("", Color.BLACK, gui);
	}

	@Override
	public void actionPerformed (ActionEvent e)
	{
		if (e.getActionCommand().equals("choose color"))
		{
			Color newColor = JColorChooser.showDialog(gui.frame, "Choose Color", chosenColor);
			if (newColor != null)
			{
				chosenColor = newColor;
				colorLabel.setForeground(chosenColor);
			}
		}
		else if (e.getActionCommand().equals("remove"))
		{
			gui.removeSplitSetting(this);
		}
	}

	public Color getColor ()
	{
		return chosenColor;
	}

	public String getName ()
	{
		return textField.getText();
	}

	public String toConfig ()
	{
		return chosenColor.getRed() + " " +  chosenColor.getGreen() + " " +  chosenColor.getBlue() + " " +  chosenColor.getAlpha() + " " + getName();
	}
}
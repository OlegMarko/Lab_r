using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TicTacToe
{
    public partial class Form1 : Form
    {
        bool turn = true;
        bool computer = false;
        string computer_button = "O";
        int turn_count = 0;
        int difficultyLevel = 0;
        int m = 0;


        public Form1()
        {
            InitializeComponent();
            computer = true;
        }

        private void newGame() 
        {
            turn = true;
            computer = true;
            turn_count = 0;

            try
            {
                foreach (Control c in Controls)
                {
                    Button b = (Button)c;
                    b.Enabled = true;
                    b.Text = "";
                }
            }
            catch
            {

            }
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show(".......", "About");
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button_click(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            
            if (turn)
            {
                b.Text = "X";
            }
            else
            {
                b.Text = "O";
            }

            turn = !turn;
            b.Enabled = false;
            turn_count++;

            checkForWinner();

            if ((!turn) && (computer))
            {
                computer_make_move();
            }
            
        }


        private void checkForWinner()
        {
            bool aWinner = false;

            if ((A1.Text == A2.Text) && (A2.Text == A3.Text) && (!A1.Enabled))
            {
                aWinner = true;
            }
            else if ((B1.Text == B2.Text) && (B2.Text == B3.Text) && (!B1.Enabled))
            {
                aWinner = true;
            }
            else if ((C1.Text == C2.Text) && (C2.Text == C3.Text) && (!C1.Enabled))
            {
                aWinner = true;
            }


            else if ((A1.Text == B1.Text) && (B1.Text == C1.Text) && (!A1.Enabled))
            {
                aWinner = true;
            }
            else if ((A2.Text == B2.Text) && (B2.Text == C2.Text) && (!A2.Enabled))
            {
                aWinner = true;
            }
            else if ((A3.Text == B3.Text) && (B3.Text == C3.Text) && (!A3.Enabled))
            {
                aWinner = true;
            }


            else if ((A1.Text == B2.Text) && (B2.Text == C3.Text) && (!A1.Enabled))
            {
                aWinner = true;
            }
            else if ((A3.Text == B2.Text) && (B2.Text == C1.Text) && (!A3.Enabled))
            {
                aWinner = true;
            }




            if (aWinner)
            {
                disableButtons();
                computer = false;

                string winner = "";
                if (turn)
                {
                    winner = "O";
                }
                else
                {
                    winner = "X";
                }

                MessageBox.Show(winner + " Wins!!!", "Winner");
            }
            else
            {
                if (turn_count == 9)
                {
                    computer = false;
                    MessageBox.Show("Not winners(((", "Winner");
                }
            }
        }

        private void disableButtons()
        {
            try
            {
                foreach (Control c in Controls)
                {
                    Button b = (Button)c;
                    b.Enabled = false;
                }
            }
            catch
            {

            }
        }

        private void newGameToolStripMenuItem_Click(object sender, EventArgs e)
        {
            turn = true;
            computer = true;
            turn_count = 0;
            difficultyLevel = 0;

            try
            {
                foreach (Control c in Controls)
                {
                    Button b = (Button)c;
                    b.Enabled = true;
                    b.Text = "";
                }
            }
            catch
            {

            }
        }

        private void button_enter(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            if (b.Enabled)
            {
                if (turn)
                {
                    b.Text = "X";
                }
                else
                {
                    b.Text = "O";
                }
            }
        }

        private void button_leave(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            if (b.Enabled)
            {
                b.Text = "";
            }
        }


        private void computer_make_move()
        {
            Button move = null;

            switch(difficultyLevel) 
            {
                case 1:
                    move = lookForOpenSpace();
                    move.PerformClick();
                break;

                case 2:
                    move = lookForWinOrBlock("O");
                    if (move == null)
                    {
                        move = lookForWinOrBlock("X");
                        if (move == null)
                        {
                            move = lookForOpenSpace();
                        }
                    }

                    move.PerformClick();
                break;

                case 3:                
                    move = lookForWinOrBlock("O");
                    if (move == null)
                    {
                        move = lookForWinOrBlock("X");
                        if (move == null)
                        {
                                move = lookForCenter();
                                if (move == null)
                                {
                                    move = lookForCorner();
                                    if (move == null)
                                    {
                                        move = lookForOpenSpace();
                                    }
                                }
                            }
                        }

                    move.PerformClick();
                break;
            }
            if (difficultyLevel == 0 && m == 0)
            {
                MessageBox.Show(".......", "About");
                m++;
            }
        }


        private Button lookForWinOrBlock(string mark)
        {
            Console.WriteLine("Looking for win or block " + mark);

            if ((A1.Text == mark) && (A2.Text == mark) && (A3.Text == ""))
            {
                return A3;
            }
            if ((A2.Text == mark) && (A3.Text == mark) && (A1.Text == ""))
            {
                return A1;
            }
            if ((A1.Text == mark) && (A3.Text == mark) && (A2.Text == ""))
            {
                return A2;
            }

            if ((B1.Text == mark) && (B2.Text == mark) && (B3.Text == ""))
            {
                return B3;
            }
            if ((B2.Text == mark) && (B3.Text == mark) && (B1.Text == ""))
            {
                return B1;
            }
            if ((B1.Text == mark) && (B3.Text == mark) && (B2.Text == ""))
            {
                return B2;
            }

            if ((C1.Text == mark) && (C2.Text == mark) && (C3.Text == ""))
            {
                return C3;
            }
            if ((C2.Text == mark) && (C3.Text == mark) && (C1.Text == ""))
            {
                return C1;
            }
            if ((C1.Text == mark) && (C3.Text == mark) && (C2.Text == ""))
            {
                return C2;
            }



            if ((A1.Text == mark) && (B1.Text == mark) && (C1.Text == ""))
            {
                return C1;
            }
            if ((A2.Text == mark) && (B2.Text == mark) && (C2.Text == ""))
            {
                return C2;
            }
            if ((A3.Text == mark) && (B3.Text == mark) && (C3.Text == ""))
            {
                return C3;
            }

            if ((A1.Text == mark) && (C1.Text == mark) && (B1.Text == ""))
            {
                return B1;
            }
            if ((A2.Text == mark) && (C2.Text == mark) && (B2.Text == ""))
            {
                return B2;
            }
            if ((A3.Text == mark) && (C3.Text == mark) && (B3.Text == ""))
            {
                return B3;
            }

            if ((B1.Text == mark) && (C1.Text == mark) && (A1.Text == ""))
            {
                return A1;
            }
            if ((B2.Text == mark) && (C2.Text == mark) && (A2.Text == ""))
            {
                return A2;
            }
            if ((C3.Text == mark) && (B3.Text == mark) && (A3.Text == ""))
            {
                return A3;
            }



            if ((A1.Text == mark) && (B2.Text == mark) && (C3.Text == ""))
            {
                return C3;
            }
            if ((A1.Text == mark) && (C3.Text == mark) && (B2.Text == ""))
            {
                return B2;
            }
            if ((C3.Text == mark) && (B2.Text == mark) && (A1.Text == ""))
            {
                return A1;
            }

            if ((A3.Text == mark) && (B2.Text == mark) && (C1.Text == ""))
            {
                return C1;
            }
            if ((A3.Text == mark) && (C1.Text == mark) && (B2.Text == ""))
            {
                return B2;
            }
            if ((C1.Text == mark) && (B2.Text == mark) && (A3.Text == ""))
            {
                return A3;
            }

            return null;
        }

        private Button lookForCenter()
        {
            if (B2.Text == "")
                return B2;

            return null;
        }

        private Button lookForCorner()
        {
            Console.WriteLine("Looking for corner");

            if (A1.Text == "O")
            {
                if (A3.Text == "")
                    return A3;
                if (C3.Text == "")
                    return C3;
                if (C1.Text == "")
                    return C1;
            }

            if (A3.Text == "O")
            {
                if (A1.Text == "")
                    return A3;
                if (C3.Text == "")
                    return C3;
                if (C1.Text == "")
                    return C1;
            }

            if (C3.Text == "O")
            {
                if (A1.Text == "")
                    return A1;
                if (A3.Text == "")
                    return A3;
                if (C1.Text == "")
                    return C1;
            }

            if (C1.Text == "O")
            {
                if (A1.Text == "")
                    return A1;
                if (A3.Text == "")
                    return A3;
                if (C3.Text == "")
                    return C3;
            }

            if (A1.Text == "")
                return A1;
            if (A3.Text == "")
                return A3;
            if (C1.Text == "")
                return C1;
            if (C3.Text == "")
                return C3;

            return null;
        }

        private Button lookForOpenSpace()
        {
            Console.WriteLine("Looking for open space");
            Button b = null;
            int i = 0;
            Button[] btns = new Button[9];

            foreach (Control c in Controls)
            {
                b = c as Button;

                if (b != null)
                {
                    if (b.Text == "")
                        btns[i] = b;
                }

                i++;
            }

            Random rand = new Random();
            i = rand.Next(i-1);

            if (btns[i] != null)
            {
                return btns[i];
            }
            else
            {
                return null;
            }
        }

        private void toolStripMenuItem3_Click(object sender, EventArgs e)
        {
            newGame();
            difficultyLevel = 1;
        }

        private void toolStripMenuItem4_Click(object sender, EventArgs e)
        {
            newGame();
            difficultyLevel = 2;
        }

        private void toolStripMenuItem5_Click(object sender, EventArgs e)
        {
            newGame();
            difficultyLevel = 3;
        }

        private void xOrYToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string message = "X -> Да   or   O -> Нет";
            string caption = "X or O";
            MessageBoxButtons buttons = MessageBoxButtons.YesNo;
            DialogResult result;

            result = MessageBox.Show(message, caption, buttons);

            if (result == System.Windows.Forms.DialogResult.Yes)
            {
                computer_button = "O";
            }

            if (result == System.Windows.Forms.DialogResult.No)
            {
                computer_button = "X";
            }
        }
    }
}

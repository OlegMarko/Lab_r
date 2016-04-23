using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lissajous_curve
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        public void funcLissajous(int time0, int timeN, double A, double a, double B, double b, double delta) 
        {
            for (int t = time0; t < timeN; t++)
            {
                double X = A * Math.Sin(a * t + delta);
                double Y = B * Math.Sin(b * t);
                chart1.Series[0].Points.AddXY(X, Y);
            }
        }

        int N = 0;

        private void timer1_Tick(object sender, EventArgs e)
        {
            chart1.Series[0].Points.Clear();
            N++;

            int time0;
            int timeN;
            double A;
            double B;
            double a;
            double b;
            double delta;


            if (textBox1.Text == "")
            {
                time0 = 0;
            }
            else
            {
                time0 = Convert.ToInt32(textBox1.Text);
            }

            if (textBox2.Text == "")
            {
                timeN = N;
            }
            else
            {
                timeN = Convert.ToInt32(textBox2.Text);
            }

            if (textBox3.Text == "")
            {
                A = N + 1;
            }
            else
            {
                A = Convert.ToDouble(textBox3.Text);
            }

            if (textBox4.Text == "")
            {
                B = N + 1;
            }
            else
            {
                B = Convert.ToDouble(textBox4.Text);
            }

            if (textBox5.Text == "")
            {
                a = N + 1;
            }
            else
            {
                a = Convert.ToDouble(textBox5.Text);
            }

            if (textBox6.Text == "")
            {
                b = N + 4;
            }
            else
            {
                b = Convert.ToDouble(textBox6.Text);
            }

            if (textBox7.Text == "")
            {
                delta = (N-1)/N * (Math.PI/2);
            }
            else
            {
                delta = Convert.ToDouble(textBox7.Text);
            }
            

            funcLissajous(time0, timeN, A, a, B, b, delta);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (timer1.Enabled)
            {
                timer1.Enabled = false;
                button1.Text = "START";
            }
            else
            {
                timer1.Enabled = true;
                button1.Text = "STOP";
            }
        }

        private void hScrollBar1_Scroll(object sender, ScrollEventArgs e)
        {
            timer1.Interval = hScrollBar1.Value;
        }
    }
}

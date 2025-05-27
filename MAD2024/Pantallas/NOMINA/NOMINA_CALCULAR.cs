using MAD2024Prueba.Pantallas.NOMINA;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace MAD2024Prueba.Pantallas
{
    public partial class NOMINA_CALCULAR : Form
    {
        //int CantDias = 31;
        string MesEscogido;
        int AñoEscogido;
        public NOMINA_CALCULAR()
        {
            InitializeComponent();
        }

        private void NOMINA_CALCULAR_Load(object sender, EventArgs e)
        {
            comboBox1.Items.Add("ENE");
            comboBox1.Items.Add("FEB");
            comboBox1.Items.Add("MAR");
            comboBox1.Items.Add("ABR");
            comboBox1.Items.Add("MAY");
            comboBox1.Items.Add("JUN");
            comboBox1.Items.Add("JUL");
            comboBox1.Items.Add("AGO");
            comboBox1.Items.Add("SEP");
            comboBox1.Items.Add("OCT");
            comboBox1.Items.Add("NOV");
            comboBox1.Items.Add("DIC");
            comboBox1.SelectedIndex = comboBox1.Items.Count - 8;

            textBox1.Text = "2025";

            MesEscogido = comboBox1.Text;
            AñoEscogido = Int32.Parse(textBox1.Text);

            


            



        }


        private void button2_Click_1(object sender, EventArgs e)
        {
            
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            //if (comboBox1.Text == "Mayo")
            //{
            //    MessageBox.Show("Do you want to continue?", "Question", MessageBoxButtons.YesNo);
            //}

            NOMINA_RECIBO frm = new NOMINA_RECIBO();
            frm.MesEscogido = MesEscogido;
            frm.AñoEscogido = AñoEscogido;
            frm.ShowDialog();


        }
    }
}

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
using WindowsFormsApplication1;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace MAD2024Prueba.Pantallas
{
    public partial class NOMINA_CALCULAR : Form
    {
        //int CantDias = 31;
        string MesEscogido_string;
        int MesEscogido_int;
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


            //ComboboxItem selectedCar = (ComboboxItem)comboBox2.SelectedItem;
            //int selecteVal = Convert.ToInt32(selectedCar.Value);


            //object selectedValue = comboBox1.SelectedItem;



            //MesEscogido_int = comboBox1.Items.IndexOf(selectedValue);

            

            


            



        }
        private void button1_Click(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();

            //conex.Truncar();


            MesEscogido_int = comboBox1.SelectedIndex + 1;

            MesEscogido_string = comboBox1.Text;
            AñoEscogido = Int32.Parse(textBox1.Text);



            
            var TABLA_EMPLEADO = new DataTable();
            TABLA_EMPLEADO = conex.IMPRIMIR_EMPLEADO();
            int CantColumnasEmpleados = TABLA_EMPLEADO.Rows.Count;

            for (int i = 1; i <= CantColumnasEmpleados; i++)
            {
                conex.Agregar_RECIBO_NOMINA(i, MesEscogido_int, AñoEscogido);
            }





            //conex.Agregar_RECIBO_NOMINA(3, 1, 2023);



            //if (comboBox1.Text == "Mayo")
            //{
            //    MessageBox.Show("Do you want to continue?", "Question", MessageBoxButtons.YesNo);
            //}

            //NOMINA_RECIBO frm = new NOMINA_RECIBO();

            NOMINA_EscogerEmpleado frm = new NOMINA_EscogerEmpleado();

            //frm.MesEscogido = MesEscogido_string;
            //frm.AñoEscogido = AñoEscogido;
            frm.ShowDialog();


        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            NOMINA_EscogerEmpleado frm = new NOMINA_EscogerEmpleado();

            //frm.MesEscogido = MesEscogido_string;
            //frm.AñoEscogido = AñoEscogido;
            frm.ShowDialog();
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


    }
}

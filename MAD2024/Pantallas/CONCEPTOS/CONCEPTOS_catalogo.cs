using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics.Contracts;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApplication1;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace MAD2024Prueba.Pantallas
{
    public partial class CONCEPTOS_catalogo : Form
    {
        public CONCEPTOS_catalogo()
        {
            InitializeComponent();
        }

        private void CONCEPTOS_catalogo_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var CONCEPTOS = new DataTable();
            var EMPLEADOS = new DataTable();
            //var CONCEPTO = new DataTable();

            CONCEPTOS = conex.IMPRIMIR_CONCEPTO();
            EMPLEADOS = conex.IMPRIMIR_EMPLEADO();

            int Filas_Empleados;
            int Filas_Conceptos;



            Filas_Empleados = EMPLEADOS.Rows.Count;
            Filas_Conceptos = CONCEPTOS.Rows.Count;
            var ID_Emp = EMPLEADOS.Rows[0][1];
            var ID_Con = CONCEPTOS.Rows[0][1];

            for (int i = 0; i < Filas_Empleados; i++)
            {
                //conex.Agregar_RECIBO_NOMINA(i, MesEscogido_int, AñoEscogido);

                ID_Emp = EMPLEADOS.Rows[i][1];
                comboBox1.Items.Add(ID_Emp.ToString());
            }

            for (int i = 3; i < Filas_Conceptos; i++)
            {
                //conex.Agregar_RECIBO_NOMINA(i, MesEscogido_int, AñoEscogido);

                ID_Con = CONCEPTOS.Rows[i][1];
                comboBox2.Items.Add(ID_Con.ToString());
            }



            comboBox1.SelectedIndex = 0;
            comboBox2.SelectedIndex = 0;





            comboBox3.Items.Add("ENE");
            comboBox3.Items.Add("FEB");
            comboBox3.Items.Add("MAR");
            comboBox3.Items.Add("ABR");
            comboBox3.Items.Add("MAY");
            comboBox3.Items.Add("JUN");
            comboBox3.Items.Add("JUL");
            comboBox3.Items.Add("AGO");
            comboBox3.Items.Add("SEP");
            comboBox3.Items.Add("OCT");
            comboBox3.Items.Add("NOV");
            comboBox3.Items.Add("DIC");
            comboBox3.SelectedIndex = comboBox3.Items.Count - 8;



            dataGridView1.DataSource = CONCEPTOS;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int ConceptoEscogido = comboBox2.SelectedIndex + 1;
            int EmpleadoEscogido = comboBox1.SelectedIndex + 1;
            int MesEscogido = comboBox3.SelectedIndex + 1;
            
            string Fecha = "03/01/2003";

            var conex = new EnlaceDB();
            //conex.Asignar_Concepto(EmpleadoEscogido, ConceptoEscogido, Fecha);
            
            //conex.Agregar_EMPLEADO(contra, Nombre, ApPat, ApMat, FechaNacimiento, CURP, NSS, RFC, Email, telefono, Banco, empresa, Puesto, Departamento, Direcion);
            Close();
        }


        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        
    }
}

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

namespace MAD2024Prueba.Pantallas.NOMINA
{
    public partial class NOMINA_EscogerEmpleado : Form
    {
        public NOMINA_EscogerEmpleado()
        {
            InitializeComponent();
        }

        private void NOMINA_EscogerEmpleado_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var TABLA_RECIBOS = new DataTable();

            TABLA_RECIBOS = conex.IMPRIMIR_RECIBO();

            dataGridPERCEPCION.DataSource = TABLA_RECIBOS;

            
            //comboBox1.Items.Add("DIC");
            

            //comboBox2

            //var TABLA_EMPLEADO = new DataTable();
            //TABLA_EMPLEADO = conex.IMPRIMIR_EMPLEADO();
            int CantColumnasRecibos = TABLA_RECIBOS.Rows.Count;
            var ID_Recibo = TABLA_RECIBOS.Rows[0][0];

            for (int i = 0; i < CantColumnasRecibos; i++)
            {
                //conex.Agregar_RECIBO_NOMINA(i, MesEscogido_int, AñoEscogido);

                ID_Recibo = TABLA_RECIBOS.Rows[i][0];
                comboBox2.Items.Add(ID_Recibo.ToString());
            }

            comboBox2.SelectedIndex = 0;





        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void Butt_MOSTRAR_Click(object sender, EventArgs e)
        {
            NOMINA_RECIBO frm = new NOMINA_RECIBO();

            //frm.MesEscogido = MesEscogido_string;
            //MesEscogido_int = comboBox1.SelectedIndex + 1;
            frm.EmpleadoEscogido = comboBox2.SelectedIndex + 1;
            frm.ShowDialog();
        }

        
    }
}

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

namespace MAD2024Prueba.Pantallas
{
    public partial class NOMINA_HEADCOUNTER : Form
    {
        public NOMINA_HEADCOUNTER()
        {
            InitializeComponent();
        }

        private void NOMINA_HEADCOUNTER_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();
            var tblAlumnos2 = new DataTable();

            tblAlumnos = conex.IMPRIMIR_REPORTE_HEADCOUNTER_1();
            tblAlumnos2 = conex.IMPRIMIR_REPORTE_HEADCOUNTER_2();

            dataGridView1.DataSource = tblAlumnos;
            dataGridView2.DataSource = tblAlumnos2;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        
    }
}

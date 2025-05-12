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
    public partial class EMPLEADOS_catalogo : Form
    {
        public EMPLEADOS_catalogo()
        {
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void EMPLEADOS_catalogo_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.IMPRIMIR_EMPLEADO();

            dataGridView1.DataSource = tblAlumnos;
        }
    }
}

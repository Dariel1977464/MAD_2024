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
    public partial class DEPARTAMENTOS_capturar : Form
    {
        public DEPARTAMENTOS_capturar()
        {
            InitializeComponent();
        }

        private void DEPARTAMENTOS_capturar_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.DepartamentosImprimir();

            dataGridView1.DataSource = tblAlumnos;
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            Close();
        }
    }
}

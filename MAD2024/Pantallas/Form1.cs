using MAD2024Prueba.Pantallas;
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

namespace MAD2024Prueba
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.ListaAlumnos(6);

            

            //tblAlumnos = conex.ListaAlumnos

            //grdAlumnos.DataSource = tblAlumnos;

        }

        

        private void button2_Click(object sender, EventArgs e)
        {
            System.Windows.Forms.Application.Exit();
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //ShowDialog(MENU);
            MENU_Main frm = new MENU_Main();
            frm.ShowDialog();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}

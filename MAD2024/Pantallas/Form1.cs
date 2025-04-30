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
            Size = new Size(670, 250);

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
            Location = new Point(121, 164);
            MENU_Main frm = new MENU_Main();
            
            frm.ShowDialog();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }
    }
}

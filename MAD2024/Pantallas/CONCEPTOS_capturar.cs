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
    public partial class CONCEPTOS_capturar : Form
    {
        bool Alterar_Fila = false;
        int Fila_Valor = 0;
        int ID_Fila;
        public CONCEPTOS_capturar()
        {
            InitializeComponent();
        }



        private void CONCEPTOS_capturar_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.ConceptosImprimir();

            dataGridView1.DataSource = tblAlumnos;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            ID_Fila = (int)dataGridView1.CurrentRow.Cells[0].Value;
            if (Alterar_Fila == true)
            {
                if (MessageBox.Show("Se alterará fila con ID: " + ID_Fila.ToString(), "¿Esta seguro?", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    //Hacer Logica Aqui
                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "AGREGAR CONCEPTOS";
            button3.Text = "Agregar";
            Alterar_Fila = false;
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "MODIFICAR CONCEPTOS";
            button3.Text = "Modificar";
            Alterar_Fila = true;
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = " ELIMINAR CONCEPTOS";
            button3.Text = "Eliminar";
            Alterar_Fila = true;
        }
    }
}

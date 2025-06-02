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
    public partial class DEPARTAMENTOS_capturar : Form
    {
        bool Alterar_Fila = false;
        int Fila_Valor = 0;
        int ID_Fila;
        public DEPARTAMENTOS_capturar()
        {
            InitializeComponent();
        }

        private void DEPARTAMENTOS_capturar_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.IMPRIMIR_DEPARTAMENTO();

            dataGridView1.DataSource = tblAlumnos;
        }


        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        

        private void button3_Click(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();

            string NombreDepa = textBox2.Text;
            int SueldoBase = Int32.Parse(textBox3.Text);




            //conex.Agregar_DEPARTAMENTO(NombreDepa, SueldoBase);



            ID_Fila = (int)dataGridView1.CurrentRow.Cells[0].Value;
            if (Alterar_Fila == true)
            {
                if (MessageBox.Show("Se alterará fila con ID: " + ID_Fila.ToString(), "¿Esta seguro?", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    //Hacer Logica Aqui
                }
            }

            Close();


        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "AGREGAR DEPARTAMENTOS";
            button3.Text = "Agregar";
            Alterar_Fila = false;
        }
        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "MODIFICAR DEPARTAMENTOS";
            button3.Text = "Modificar";
            Alterar_Fila = true;
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "ELIMINAR DEPARTAMENTOS";
            button3.Text = "Eliminar";
            Alterar_Fila = true;
        }
    }
}

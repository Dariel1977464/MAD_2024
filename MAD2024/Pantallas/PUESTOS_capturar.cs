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
using static System.Net.Mime.MediaTypeNames;

namespace MAD2024Prueba.Pantallas
{
    public partial class PUESTOS_capturar : Form
    {
        bool Alterar_Fila = false;
        int Fila_Valor = 0;
        int ID_Fila;
        public PUESTOS_capturar()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void PUESTOS_capturar_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.IMPRIMIR_PUESTO();

            dataGridView1.DataSource = tblAlumnos;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            //var Agregar = new DataTable();
            //var Agregar = new ParamArrayAttribute;
            //string pruebaba = " ";
            //pruebaba = comboBox1.Text;


            string Dato1 = " ";
            float Dato2 = 0.5f;

            Dato1 = textBox1.Text;
            //Dato2 Aca esta se llenaria igual, peor tendrias que castear el string a un float para que se guarde bien


            conex.Agregar_PUESTO(Dato1, Dato2);

            

            
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        private void button3_Click_1(object sender, EventArgs e)
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

        private void radioButton1_CheckedChanged_1(object sender, EventArgs e)
        {
            this.Text = "AGREGAR PUESTOS";
            button3.Text = "Agregar";
            Alterar_Fila = false;
        }
        private void radioButton2_CheckedChanged_1(object sender, EventArgs e)
        {
            this.Text = "MODIFICAR PUESTOS";
            button3.Text = "Modificar";
            Alterar_Fila = true;
        }

        private void radioButton3_CheckedChanged_1(object sender, EventArgs e)
        {
            this.Text = "ELIMINAR PUESTOS";
            button3.Text = "Eliminar";
            Alterar_Fila = true;
        }

    }
}

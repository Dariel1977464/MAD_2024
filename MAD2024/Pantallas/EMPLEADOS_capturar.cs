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
    public partial class EMPLEADOS_capturar : Form
    {
        bool Alterar_Fila = false;
        int Fila_Valor = 0;
        int ID_Fila;
        public EMPLEADOS_capturar()
        {
            InitializeComponent();
        }

        private void EMPLEADOS_capturar_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.EmpleadosImprimir();

            dataGridView1.DataSource = tblAlumnos;
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            Close();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox2.ReadOnly = true;
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "AGREGAR EMPLEADOS";
            textBox2.ReadOnly = false;
            textBox3.ReadOnly = false;
            dateTimePicker1.Enabled = true;
            textBox5.ReadOnly = false;
            textBox6.ReadOnly = false;
            textBox7.ReadOnly = false;
            textBox8.ReadOnly = false;
            textBox9.ReadOnly = false;
            
            textBox3.Enabled = true;
            textBox6.Enabled = true;

            comboBox1.Enabled = true;
            comboBox2.Enabled = true;

            button3.Text = "Agregar";

            
            dataGridView1.Enabled = false;

            Alterar_Fila = false;


        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "EDITAR EMPLEADOS";
            textBox3.ReadOnly = true;
            textBox3.Enabled = false;
            textBox6.ReadOnly = true;
            textBox6.Enabled = false;
            dateTimePicker1.Enabled = false;
            dataGridView1.Enabled = false;

            comboBox1.Enabled = false;
            comboBox2.Enabled = false;

            

            button3.Text = "Editar";


            Alterar_Fila = true;



        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "ELIMINAR EMPLEADOS";
            textBox2.ReadOnly = false;
            dataGridView1.Enabled = true;

            button3.Text = "Eliminar";


            
            //ID_Fila = (int)dataGridView1.CurrentRow.Cells[0].Value;
            //textBox4.Text = ID_Fila.ToString();

            Alterar_Fila = true;

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
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

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}

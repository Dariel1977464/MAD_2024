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
            var TABLA_EMPLEADOS =      new DataTable();
            var TABLA_DEPARTAMENTO = new DataTable();
            var TABLA_PUESTO =           new DataTable();
            int Filas_Departamento = 0;
            int Filas_Puesto = 0;

            TABLA_EMPLEADOS = conex.IMPRIMIR_EMPLEADO();
            TABLA_DEPARTAMENTO = conex.IMPRIMIR_DEPARTAMENTO();
            TABLA_PUESTO = conex.IMPRIMIR_PUESTO();

            dataGridView1.DataSource = TABLA_EMPLEADOS;

            #region COMBOBOX DEPARTAMENTO

            Filas_Departamento = TABLA_DEPARTAMENTO.Rows.Count;
            var ID_Departamento = TABLA_DEPARTAMENTO.Rows[0][0];

            for (int i = 0; i < Filas_Departamento; i++)
            {
                //conex.Agregar_RECIBO_NOMINA(i, MesEscogido_int, AñoEscogido);

                ID_Departamento = TABLA_DEPARTAMENTO.Rows[i][1];
                comboBox3.Items.Add(ID_Departamento.ToString());
            }

            comboBox3.SelectedIndex = 0;

            #endregion


            #region COMBOBOX PUESTO
            Filas_Puesto = TABLA_PUESTO.Rows.Count;
            object ID_Puestos = TABLA_PUESTO.Rows[0][1];

            for (int i = 0; i < Filas_Puesto; i++)
            {
                ID_Puestos = TABLA_PUESTO.Rows[i][1];
                comboBox1.Items.Add(ID_Puestos.ToString());
            }
            comboBox1.SelectedIndex = 0;


            #endregion




            //int CantColumnasPuesto = TABLA_PUESTO.Rows.Count;
            //var ID_Puesto = TABLA_PUESTO.Rows[0][0];

            //for (int i = 0; i < CantColumnasPuesto; i++)
            //{
            //    //conex.Agregar_RECIBO_NOMINA(i, MesEscogido_int, AñoEscogido);

            //    ID_Recibo = TABLA_PUESTO.Rows[i][2];
            //    comboBox2.Items.Add(ID_Puesto.ToString());
            //}


        }

        private void button1_Click(object sender, EventArgs e)
        {
            //textBox2.ReadOnly = true;
            string Nombre, ApPat, ApMat,
                contra, FechaNacimiento, CURP, NSS,
                RFC, Email;
            string telefono;
            int Banco, Departamento, Puesto, Direcion, empresa;


            Nombre = textBox3.Text;
            ApPat = textBox1.Text;
            ApMat = textBox4.Text;
            telefono = "8241260908";

            contra = textBox2.Text;

            var FechaTest = dateTimePicker1.Text;

            FechaNacimiento = FechaTest.ToString();

            //string sqlFormattedDate = myDateTime.ToString("yyyy-MM-dd HH:mm:ss.fff");
//            FechaNacimiento = FechaTest.ToString("yyyy-MM-dd");

            CURP = textBox5.Text;
            NSS = textBox6.Text;
            RFC = textBox7.Text;
            Email = textBox9.Text;

            Banco = 1;
            Departamento = comboBox3.SelectedIndex + 1;
            Puesto = comboBox1.SelectedIndex + 1;
            Direcion = 1;
            empresa = 1;


            var conex = new EnlaceDB();
            //conex.Agregar_EMPLEADO(contra, Nombre, ApPat, ApMat, FechaNacimiento, CURP, NSS, RFC, Email, telefono, Banco, empresa, Puesto, Departamento, Direcion);
            //conex.


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
        private void button3_Click(object sender, EventArgs e)
        {
            //textBox2.ReadOnly = true;
            string Nombre, ApPat, ApMat,
                contra, FechaNacimiento, CURP, NSS,
                RFC, Email;
            string telefono;
            int Banco, Departamento, Puesto, Direcion, empresa;


            Nombre = textBox3.Text;
            ApPat = textBox1.Text;
            ApMat = textBox4.Text;
            telefono = "8241260908";

            contra = textBox2.Text;
            FechaNacimiento = dateTimePicker1.Text;
            CURP = textBox5.Text;
            NSS = textBox6.Text;
            RFC = textBox7.Text;
            Email = textBox9.Text;

            Banco = 1;

            Nombre = RemoveWhitespace(Nombre);
            ApPat = RemoveWhitespace(ApPat);
            ApMat = RemoveWhitespace(ApMat);

            //Departamento = comboBox1.SelectedIndex + 1;
            //Puesto = comboBox1.SelectedIndex + 1;
            //Direcion = 1;
            //empresa = 1;


            var conex = new EnlaceDB();
            //conex.Agregar_EMPLEADO(contra, Nombre, ApPat, ApMat, FechaNacimiento, CURP, NSS, RFC, Email, telefono, Banco, empresa, Puesto, Departamento, Direcion);


        }




        

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

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

            //comboBox1.Enabled = true;
            //comboBox2.Enabled = true;

            button1.Text = "Agregar";

            
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

            //comboBox1.Enabled = false;
            comboBox1.Enabled = false;

            

            button1.Text = "Editar";


            Alterar_Fila = true;



        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            this.Text = "ELIMINAR EMPLEADOS";
            textBox2.ReadOnly = false;
            dataGridView1.Enabled = true;

            button1.Text = "Eliminar";


            
            //ID_Fila = (int)dataGridView1.CurrentRow.Cells[0].Value;
            //textBox4.Text = ID_Fila.ToString();

            Alterar_Fila = true;

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }



        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        string RemoveWhitespace(string input)
            {
            return new string(input
                .Where(c => !Char.IsWhiteSpace(c))
                .ToArray());
            }

    }
}

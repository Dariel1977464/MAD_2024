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

namespace MAD2024Prueba.Pantallas.NOMINA
{
    public partial class NOMINA_RECIBO : Form
    {
        public string MesEscogido;
        public int AñoEscogido,
            CantDias,
            EmpleadoEscogido = 1;
        public NOMINA_RECIBO()
        {
            InitializeComponent();
        }
        private void NOMINA_RECIBO_Load(object sender, EventArgs e)
        {

            string ValorTest;
            var conex = new EnlaceDB();
            var TABLA_PERCEPCIONES = new DataTable();
            var TABLA_DEDUCCIONES = new DataTable();
            var TABLA_RECIBO = new DataTable();
            var TABLA_EMPLEADO = new DataTable();
            var TABLA_HORAS_EXTRA = new DataTable();
            var TABLA_INCAPACIDAD = new DataTable();

            TABLA_PERCEPCIONES = conex.IMPRIMIR_EN_NOMINA_PERCEPCIONES(EmpleadoEscogido);
            TABLA_DEDUCCIONES = conex.IMPRIMIR_EN_NOMINA_DEDUCCIONES(EmpleadoEscogido);
            TABLA_RECIBO = conex.IMPRIMIR_RECIBO_1_EMPLEADO(EmpleadoEscogido);
            TABLA_EMPLEADO = conex.IMPRIMIR_EMPLEADO_1(EmpleadoEscogido);
            TABLA_HORAS_EXTRA = conex.IMPRIMIR_EN_NOMINA_HORAS_EXTRA(EmpleadoEscogido);
            TABLA_INCAPACIDAD = conex.IMPRIMIR_EN_NOMINA_INCAPACIDAD(EmpleadoEscogido);

            var Empleado_Numero = TABLA_EMPLEADO.Rows[0][0];
            //var Empleado_Numero = 1;
            var Empleado_Nombre = TABLA_EMPLEADO.Rows[0][1];
            var Empleado_EMAIL = TABLA_EMPLEADO.Rows[0][2];
            var Empleado_Departamento = TABLA_EMPLEADO.Rows[0][5];
            var Empleado_Puesto = TABLA_EMPLEADO.Rows[0][6];
            var Empleado_Curp = TABLA_EMPLEADO.Rows[0][8];
            var Empleado_RFC = TABLA_EMPLEADO.Rows[0][10];

            DatoNomina_NumeroEmpleado1.Text =  "NUMERO DE EMPLEADO: " + Empleado_Numero.ToString();
            DatoNomina_Nombre1.Text = Empleado_Nombre.ToString();
            DatoNomina_Email1.Text = Empleado_EMAIL.ToString();
            DatoNomina_Departamento1.Text = "DEPARTAMENTO: " + Empleado_Departamento.ToString();
            DatoNomina_Puesto1.Text = "PUESTO: " + Empleado_Puesto.ToString();
            DatoNomina_Curp1.Text = Empleado_Curp.ToString();
            DatoNomina_RFC1.Text = Empleado_RFC.ToString();

            int Cantidad_Filas = TABLA_PERCEPCIONES.Rows.Count;
            var Total_Gravado = TABLA_PERCEPCIONES.Rows[0][2];
            var temp_tabla = TABLA_PERCEPCIONES.Rows[0][3];
            float Gravado_Extento = 0;
            float temp_float = 0;


            var Total_Extento = TABLA_PERCEPCIONES.Rows[0][3];

            

            for (int i = 0; i < Cantidad_Filas; i++)
            {
                temp_tabla = TABLA_PERCEPCIONES.Rows[i][3];

                float.TryParse(temp_tabla.ToString(), out temp_float);

                Gravado_Extento += temp_float;   
            }

            DatoNomina_Total_Gravado1.Text = "$" + Total_Gravado.ToString();

            DatoNomina_Total_Extento1.Text = "$" + Gravado_Extento.ToString() + ".0000";

            var Total_Deducciones = TABLA_DEDUCCIONES.Rows[0][2];
            Cantidad_Filas = TABLA_DEDUCCIONES.Rows.Count;

            Cantidad_Filas = TABLA_DEDUCCIONES.Rows.Count;
            Total_Gravado = TABLA_DEDUCCIONES.Rows[0][2];
            temp_tabla = TABLA_DEDUCCIONES.Rows[0][2];
            Gravado_Extento = 0;
            temp_float = 0;


            for (int i = 0; i < Cantidad_Filas; i++)
            {
                temp_tabla = TABLA_DEDUCCIONES.Rows[i][2];

                float.TryParse(temp_tabla.ToString(), out temp_float);

                Gravado_Extento += temp_float;
            }

            DatoNomina_Total_Deducciones1.Text = "$" + Gravado_Extento.ToString() + ".0000";
            DatoNomina_Impuestos_Retenidos1.Text = "$0.0000";





            var Recibo_Fecha = TABLA_RECIBO.Rows[0][2];

            var Cantidad_Depositada = TABLA_RECIBO.Rows[0][4];

            DatoNomina_Total1.Text = "$" + Cantidad_Depositada.ToString();


            ValorTest = Recibo_Fecha.ToString();

            #region Calcular Fecha
            if (MesEscogido == "FEB")
            {
                CantDias = 28;
            }
            else if (MesEscogido == "ABR" ||
                MesEscogido == "JUN" ||
                MesEscogido == "SEP" ||
                MesEscogido == "NOV")
            {
                CantDias = 30;

            }
            else
            {
                CantDias = 31;
            }

            DatoNomina_Fecha1.Text = Recibo_Fecha.ToString();

            ValorTest = Recibo_Fecha.ToString();
            ValorTest.Substring(2);
            //ValorTest.Remove(0,1);


            DatoNomina_Fecha2.Text = ValorTest.ToString();
            DatoNomina_Fecha3.Text = Recibo_Fecha.ToString();


            //DatoNomina_Fecha1.Text = CantDias.ToString() + "/" + MesEscogido + "/" + AñoEscogido.ToString();
            //DatoNomina_Fecha2.Text = "01" + "/" + MesEscogido + "/" + AñoEscogido.ToString();
            //DatoNomina_Fecha3.Text = CantDias.ToString() + "/" + MesEscogido + "/" + AñoEscogido.ToString();
            #endregion

            //CantDias;

            //textBox1.Text = ValorTest;



            dataGridPERCEPCION.DataSource = TABLA_PERCEPCIONES;
            dataGridDEDUCCION.DataSource = TABLA_DEDUCCIONES;
            dataGridHORAS_EXTRA.DataSource = TABLA_HORAS_EXTRA;
            dataGridINCAPACIDAD.DataSource = TABLA_INCAPACIDAD;

        }

        private void label1_Click(object sender, EventArgs e)
        {
            
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void splitContainer1_Panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label33_Click(object sender, EventArgs e)
        {

        }

        private void tableLayoutPanel3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label15_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}

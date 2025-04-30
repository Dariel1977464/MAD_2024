using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MAD2024Prueba.Pantallas
{
    public partial class MENU_Main : Form
    {
        public MENU_Main()
        {
            InitializeComponent();
        }

        private void MENU_Main_Load(object sender, EventArgs e)
        {

        }

        #region DEPARTAMENTO
        private void capturarDepartamentoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DEPARTAMENTOS_capturar frm = new DEPARTAMENTOS_capturar();
            frm.ShowDialog();
        }


        #endregion

        #region PUESTO
        private void capturarPuestoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PUESTOS_capturar frm = new PUESTOS_capturar();
            frm.ShowDialog();
        }

        #endregion

        #region EMPLEADO
        private void capturarEmpleadoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            EMPLEADOS_capturar frm = new EMPLEADOS_capturar();
            frm.ShowDialog();
        }

        #endregion

        #region CONCEPTO
        private void capturarConceptoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CONCEPTOS_capturar frm = new CONCEPTOS_capturar();
            frm.ShowDialog();
        }

        private void catalogoDeConceptosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CONCEPTOS_catalogo frm = new CONCEPTOS_catalogo();
            frm.ShowDialog();
        }

        #endregion


        private void calculoDeNominaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            NOMINA_CALCULAR frm = new NOMINA_CALCULAR();
            frm.ShowDialog();
        }

        private void reporteDeNominaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            NOMINA_Reporte_General frm = new NOMINA_Reporte_General();
            frm.ShowDialog();
        }

        private void reportesDeNominaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            NOMINA_Reportes frm = new NOMINA_Reportes();
            frm.ShowDialog();
        }

        private void reporteHeadcounterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            NOMINA_HEADCOUNTER frm = new NOMINA_HEADCOUNTER();
            frm.ShowDialog();
        }

        private void catálogoDeDepartamentosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DEPARTAMENTOS_catalogo frm = new DEPARTAMENTOS_catalogo();
            frm.ShowDialog();
        }

        private void catálogoDePuestosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            PUESTOS_catalogo frm = new PUESTOS_catalogo();
            frm.ShowDialog();
        }

        private void catálogoDeEmpleadosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            EMPLEADOS_catalogo frm = new EMPLEADOS_catalogo();
            frm.ShowDialog();
        }
    }
}

﻿using System;
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
    public partial class NOMINA_Reportes : Form
    {
        public NOMINA_Reportes()
        {
            InitializeComponent();
        }
        private void NOMINA_Reportes_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.IMPRIMIR_REPORTE_NOMINA();

            dataGridView2.DataSource = tblAlumnos;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        
    }
}

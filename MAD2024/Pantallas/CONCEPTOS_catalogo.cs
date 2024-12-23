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
    public partial class CONCEPTOS_catalogo : Form
    {
        public CONCEPTOS_catalogo()
        {
            InitializeComponent();
        }

        private void CONCEPTOS_catalogo_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.ConceptosImprimir();

            dataGridView1.DataSource = tblAlumnos;
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            Close();
        }
    }
}
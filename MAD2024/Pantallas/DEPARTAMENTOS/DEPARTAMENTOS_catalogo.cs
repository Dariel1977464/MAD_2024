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
    public partial class DEPARTAMENTOS_catalogo : Form
    {
        public DEPARTAMENTOS_catalogo()
        {
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void DEPARTAMENTOS_catalogo_Load(object sender, EventArgs e)
        {
            var conex = new EnlaceDB();
            var tblAlumnos = new DataTable();

            tblAlumnos = conex.IMPRIMIR_DEPARTAMENTO();

            dataGridView1.DataSource = tblAlumnos;
        }
    }
}

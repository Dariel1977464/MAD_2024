namespace MAD2024Prueba.Pantallas.NOMINA
{
    partial class NOMINA_EscogerEmpleado
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Butt_MOSTRAR = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.dataGridPERCEPCION = new System.Windows.Forms.DataGridView();
            this.comboBox2 = new System.Windows.Forms.ComboBox();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridPERCEPCION)).BeginInit();
            this.SuspendLayout();
            // 
            // Butt_MOSTRAR
            // 
            this.Butt_MOSTRAR.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.Butt_MOSTRAR.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.Butt_MOSTRAR.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.Butt_MOSTRAR.Font = new System.Drawing.Font("Rockwell Condensed", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Butt_MOSTRAR.Location = new System.Drawing.Point(1061, 18);
            this.Butt_MOSTRAR.Name = "Butt_MOSTRAR";
            this.Butt_MOSTRAR.Size = new System.Drawing.Size(121, 54);
            this.Butt_MOSTRAR.TabIndex = 66;
            this.Butt_MOSTRAR.Text = "Mostrar";
            this.Butt_MOSTRAR.UseVisualStyleBackColor = false;
            this.Butt_MOSTRAR.Click += new System.EventHandler(this.Butt_MOSTRAR_Click);
            // 
            // button2
            // 
            this.button2.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.button2.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.button2.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.button2.Font = new System.Drawing.Font("Rockwell Condensed", 13.8F, System.Drawing.FontStyle.Bold);
            this.button2.Location = new System.Drawing.Point(1236, 18);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(121, 54);
            this.button2.TabIndex = 67;
            this.button2.Text = "Cerrar";
            this.button2.UseVisualStyleBackColor = false;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(16, 18);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(298, 29);
            this.label1.TabIndex = 65;
            this.label1.Text = "Mostrar en Detalle Recibo:";
            // 
            // dataGridPERCEPCION
            // 
            this.dataGridPERCEPCION.ColumnHeadersHeight = 29;
            this.dataGridPERCEPCION.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            this.dataGridPERCEPCION.Location = new System.Drawing.Point(1, 96);
            this.dataGridPERCEPCION.Name = "dataGridPERCEPCION";
            this.dataGridPERCEPCION.RowHeadersWidth = 15;
            this.dataGridPERCEPCION.RowTemplate.Height = 24;
            this.dataGridPERCEPCION.Size = new System.Drawing.Size(1369, 472);
            this.dataGridPERCEPCION.TabIndex = 78;
            // 
            // comboBox2
            // 
            this.comboBox2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.comboBox2.FormattingEnabled = true;
            this.comboBox2.Location = new System.Drawing.Point(320, 18);
            this.comboBox2.Name = "comboBox2";
            this.comboBox2.Size = new System.Drawing.Size(282, 37);
            this.comboBox2.TabIndex = 80;
            // 
            // NOMINA_EscogerEmpleado
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this.ClientSize = new System.Drawing.Size(1369, 567);
            this.Controls.Add(this.comboBox2);
            this.Controls.Add(this.dataGridPERCEPCION);
            this.Controls.Add(this.Butt_MOSTRAR);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.label1);
            this.Name = "NOMINA_EscogerEmpleado";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "NOMINA_EscogerEmpleado";
            this.Load += new System.EventHandler(this.NOMINA_EscogerEmpleado_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridPERCEPCION)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button Butt_MOSTRAR;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dataGridPERCEPCION;
        private System.Windows.Forms.ComboBox comboBox2;
    }
}
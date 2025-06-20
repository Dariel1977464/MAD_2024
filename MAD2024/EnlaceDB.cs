﻿/*
Autor: Alejandro Villarreal

LMAD

PARA EL PROYECTO ES OBLIGATORIO EL USO DE ESTA CLASE, 
EN EL SENTIDO DE QUE LOS DATOS DE CONEXION AL SERVIDOR ESTAN DEFINIDOS EN EL App.Config
Y NO TENER ESOS DATOS EN CODIGO DURO DEL PROYECTO.

NO SE PERMITE HARDCODE.

LOS MÉTODOS QUE SE DEFINEN EN ESTA CLASE SON EJEMPLOS, PARA QUE SE BASEN Y USTEDES HAGAN LOS SUYOS PROPIOS
Y DEFINAN Y PROGRAMEN TODOS LOS MÉTODOS QUE SEAN NECESARIOS PARA SU PROYECTO.

*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Forms;


/*
Se tiene que cambiar el namespace para el que usen en su proyecto
*/
//namespace WindowsFormsApplication1
namespace WindowsFormsApplication1
{
    public class EnlaceDB
    {
        static private string _aux { set; get; }
        static private SqlConnection _conexion;
        static private SqlDataAdapter _adaptador = new SqlDataAdapter();
        static private SqlCommand _comandosql = new SqlCommand();
        static private DataTable _tabla = new DataTable();
        static private DataSet _DS = new DataSet();

        string RemoveWhitespace(string input)
             {
            return new string(input
                .Where(c => !Char.IsWhiteSpace(c))
                .ToArray());
            }
        public DataTable obtenertabla
        {
            get
            {
                return _tabla;
            }
        }

        private static void conectar()
        {
            /*
			Para que funcione el ConfigurationManager
			en la sección de "Referencias" de su proyecto, en el "Solution Explorer"
			dar clic al botón derecho del mouse y dar clic a "Add Reference"
			Luego elegir la opción System.Configuration
			
			tal como lo vimos en clase.
			*/
            //string cnn = ConfigurationManager.ConnectionStrings["Grupo01"].ToString();
            string cnn = ConfigurationManager.ConnectionStrings["Grupo51"].ToString(); 
			// Cambiar Grupo01 por el que ustedes hayan definido en el App.Confif
            _conexion = new SqlConnection(cnn);
            _conexion.Open();
        }
        private static void desconectar()
        {
            _conexion.Close();
        }

        #region SP_PRUEBAS

        public bool Autentificar(string us, string ps)
        {
            bool isValid = false;
            try
            {
                conectar();
                string qry = "SP_ValidaUser";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 9000;

                var parametro1 = _comandosql.Parameters.Add("@u", SqlDbType.Char, 20);
                parametro1.Value = us;
                var parametro2 = _comandosql.Parameters.Add("@p", SqlDbType.Char, 20);
                parametro2.Value = ps;

                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(_tabla);

                if (_tabla.Rows.Count > 0)
                {
                    isValid = true;
                }

            }
            catch (SqlException e)
            {
                isValid = false;
            }
            finally
            {
                desconectar();
            }

            return isValid;
        }

        public DataTable get_Users()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                // Ejemplo de cómo ejecutar un query, 
                // PERO lo correcto es siempre usar SP para cualquier consulta a la base de datos
                string qry = "Select Nombre, email, Fecha_modif from Usuarios where Activo = 0;";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.Text;
                // Esta opción solo la podrían utilizar si hacen un EXEC al SP concatenando los parámetros.
                _comandosql.CommandTimeout = 1200;

                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        // Ejemplo de método para recibir una consulta en forma de tabla
        // Cuando el SP ejecutará un SELECT
        public DataTable get_Deptos(string opc)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "sp_Gestiona_Deptos";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Char, 1);
                parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        // Ejemplo de método para ejecutar un SP que no se espera que regrese información, 
        // solo que ejecute ya sea un INSERT, UPDATE o DELETE
        public bool Add_Deptos(string opc, string depto)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "sp_Gestiona_Deptos";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Char, 1);

                //parametro1 = _comandosql.Parameters.get("@Opc", SqlDbType.Char, 1);


                parametro1.Value = opc;
                var parametro2 = _comandosql.Parameters.Add("@Nombre", SqlDbType.VarChar, 20);
                parametro2.Value = depto;





                // @ReturnVal could be any name
                var returnParameter = _comandosql.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                //conn.Open();
                //_comandosql.ExecuteNonQuery();
                var result = parametro2.Value;






                _adaptador.InsertCommand = _comandosql;
                // También se tienen las propiedades del adaptador: UpdateCommand  y DeleteCommand

                _comandosql.ExecuteNonQuery();

                //var result = parametro2.Value;


            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return add;
        }

        public bool Agregar_Carreras(string product_name, string locations, string category, string plan, string coord)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "sp_HacerPrueba";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@product_name", SqlDbType.Char, 1);
                //parametro1.Value = product_name;
                //var parametro2 = _comandosql.Parameters.Add("@locations", SqlDbType.VarChar, 5);
                //parametro2.Value = locations;
                //var parametro3 = _comandosql.Parameters.Add("@category", SqlDbType.VarChar, 30);
                //parametro3.Value = category;



                //var parametro4 = _comandosql.Parameters.Add("@PlanCarr", SqlDbType.VarChar, 10);
                //parametro4.Value = plan;
                //var parametro5 = _comandosql.Parameters.Add("@Coordinador", SqlDbType.VarChar, 30);
                //parametro5.Value = coord;

                //_adaptador.InsertCommand = _comandosql;
                //// También se tienen las propiedades del adaptador: UpdateCommand  y DeleteCommand

                //_comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return add;
        }

        public DataTable ListaAlumnos(int opc)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "sp_HacerPrueba";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        #endregion

        #region SP_IMPRIMIR

        public DataTable Truncar()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "TruncarRecibos";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_DEPARTAMENTO()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_IMPRIMIR_DEPARTAMENTO";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_PUESTO()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_IMPRIMIR_PUESTO";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_EMPLEADO()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_IMPRIMIR_EMPLEADO";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_EMPLEADO_1(int EMPLEADO_ID)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_IMPRIMIR_EMPLEADO_1";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int, 1);
                parametro1.Value = EMPLEADO_ID;




                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_CONCEPTO()
            {
                var msg = "";
                DataTable tabla = new DataTable();
                try
                {
                    conectar();
                    string qry = "SP_IMPRIMIR_CONCEPTO";
                    //string qry = "DBsp_BancoLLenar";
                    _comandosql = new SqlCommand(qry, _conexion);
                    _comandosql.CommandType = CommandType.StoredProcedure;
                    _comandosql.CommandTimeout = 1200;

                    //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                    //parametro1.Value = opc;


                    _adaptador.SelectCommand = _comandosql;
                    _adaptador.Fill(tabla);
                    // la ejecución del SP espera que regrese datos en formato tabla

                }
                catch (SqlException e)
                {
                    msg = "Excepción de base de datos: \n";
                    msg += e.Message;
                    MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                }
                finally
                {
                    desconectar();
                }

                return tabla;
            }

        public DataTable IMPRIMIR_RECIBO()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_IMPRIMIR_RECIBO";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_RECIBO_1_EMPLEADO(int EMPLEADO_ID)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_IMPRIMIR_RECIBO_1_EMPLEADO";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int, 4);
                parametro1.Value = EMPLEADO_ID;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_REPORTE_NOMINA()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_REPORTE_NOMINA";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_REPORTE_GENERAL()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_REPORTE_GENERAL";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_REPORTE_HEADCOUNTER_1()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_REPORTE_HEADCOUNTER_1";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_REPORTE_HEADCOUNTER_2()
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "SP_REPORTE_HEADCOUNTER_2";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                //var parametro1 = _comandosql.Parameters.Add("@Opc", SqlDbType.Int, 4);
                //parametro1.Value = opc;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_EN_NOMINA_PERCEPCIONES(int EMPLEADO_ID)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "sp_NominaRequisito_Percepciones";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int, 1);
                parametro1.Value = EMPLEADO_ID;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_EN_NOMINA_DEDUCCIONES(int EMPLEADO_ID)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "sp_NominaRequisito_Deducciones";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int, 1);
                parametro1.Value = EMPLEADO_ID;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_EN_NOMINA_HORAS_EXTRA(int EMPLEADO_ID)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "sp_NominaRequisito_HorasExtra";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int, 1);
                parametro1.Value = EMPLEADO_ID;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }

        public DataTable IMPRIMIR_EN_NOMINA_INCAPACIDAD(int EMPLEADO_ID)
        {
            var msg = "";
            DataTable tabla = new DataTable();
            try
            {
                conectar();
                string qry = "sp_NominaRequisito_INCAPACIDAD";
                //string qry = "DBsp_BancoLLenar";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int, 1);
                parametro1.Value = EMPLEADO_ID;


                _adaptador.SelectCommand = _comandosql;
                _adaptador.Fill(tabla);
                // la ejecución del SP espera que regrese datos en formato tabla

            }
            catch (SqlException e)
            {
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            return tabla;
        }




        #endregion

        #region SP_AGREGAR
        public void Agregar_PUESTO(string Dato1, float Dato2)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "SP_AGREGAR_PUESTO";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Nombre_de_Puesto", SqlDbType.VarChar, 30);
                parametro1.Value = Dato1;
                var parametro2 = _comandosql.Parameters.Add("@Proporcion", SqlDbType.Float);
                parametro2.Value = Dato2;


                _adaptador.InsertCommand = _comandosql;


                _comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            //return add;
        }

        public void Agregar_DEPARTAMENTO(string Dato1, int Dato2)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "SP_AGREGAR_DEPARTAMENTO";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Nombre_Departamento", SqlDbType.VarChar, 20);
                parametro1.Value = Dato1;
                var parametro2 = _comandosql.Parameters.Add("@SueldoBase_Diario", SqlDbType.Int);
                parametro2.Value = Dato2;


                _adaptador.InsertCommand = _comandosql;


                _comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            //return add;
        }

        public void Agregar_EMPLEADO(
            string Dato1, string Dato2, string Dato3, string Dato4, string Dato5,
            string Dato6, string Dato7, string Dato8, string Dato9, string Dato10,
            int Dato11, int Dato12, int Dato13, int Dato14, int Dato15)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "SP_AGREGAR_EMPLEADO";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("Contrasena", SqlDbType.VarChar, 20);
                parametro1.Value = Dato1;
                var parametro2 = _comandosql.Parameters.Add("@Nombre", SqlDbType.VarChar, 30);
                parametro2.Value = Dato2;
                var parametro3 = _comandosql.Parameters.Add("@ApellidoPat", SqlDbType.VarChar, 30);
                parametro3.Value = Dato3;
                var parametro4 = _comandosql.Parameters.Add("@ApellidoMat", SqlDbType.VarChar, 30);



                parametro4.Value = Dato4;
                var parametro5 = _comandosql.Parameters.Add("@FechaNacimiento", SqlDbType.Date);
                parametro5.Value = Dato5;
                var parametro6 = _comandosql.Parameters.Add("@CURP", SqlDbType.VarChar, 18);
                parametro6.Value = Dato6;
                var parametro7 = _comandosql.Parameters.Add("@NSS", SqlDbType.VarChar, 11);
                parametro7.Value = Dato7;
                var parametro8 = _comandosql.Parameters.Add("@RFC", SqlDbType.VarChar, 13);
                parametro8.Value = Dato8;
                var parametro9 = _comandosql.Parameters.Add("@Email", SqlDbType.VarChar, 30);
                parametro9.Value = Dato9;
                var parametro10 = _comandosql.Parameters.Add("@Telefonos", SqlDbType.VarChar, 10);
                parametro10.Value = Dato10;

                var parametro11 = _comandosql.Parameters.Add("@Banco", SqlDbType.Int);
                parametro11.Value = Dato11;
                var parametro12 = _comandosql.Parameters.Add("@Empresa_FK", SqlDbType.Int);
                parametro12.Value = Dato12;
                var parametro13 = _comandosql.Parameters.Add("@PuestoFK", SqlDbType.Int);
                parametro13.Value = Dato13;
                var parametro14 = _comandosql.Parameters.Add("@DepartamentoFK", SqlDbType.Int);
                parametro14.Value = Dato14;
                var parametro15 = _comandosql.Parameters.Add("@DireccionFK", SqlDbType.Int);
                parametro15.Value = Dato15;
                


                _adaptador.InsertCommand = _comandosql;


                _comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            //return add;
        }

        public void Agregar_CONCEPTO(string Dato1, int Dato2, int Dato3, int Dato4, int Dato5, int Dato6)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "SP_AGREGAR_CONCEPTO";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Nombre_Concepto", SqlDbType.VarChar, 30);
                parametro1.Value = Dato1;
                var parametro2 = _comandosql.Parameters.Add("@Tipo", SqlDbType.Int);
                parametro2.Value = Dato2;
                var parametro3 = _comandosql.Parameters.Add("@Obligatoria", SqlDbType.Int);
                parametro3.Value = Dato3;
                var parametro4 = _comandosql.Parameters.Add("@Mensual", SqlDbType.Int);
                parametro4.Value = Dato4;
                var parametro5 = _comandosql.Parameters.Add("@Valor", SqlDbType.Int);
                parametro5.Value = Dato5;
                var parametro6 = _comandosql.Parameters.Add("@Proporcion", SqlDbType.Int);
                parametro6.Value = Dato6;


                _adaptador.InsertCommand = _comandosql;


                _comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            //return add;
        }


        public void Agregar_RECIBO_NOMINA(int EMPLEADO_ID, int MES, int AÑO)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "SP_AGREGAR_RECIBO_ALT";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleados_FK", SqlDbType.Int);
                parametro1.Value = EMPLEADO_ID;
                var parametro2 = _comandosql.Parameters.Add("@Mes", SqlDbType.Int);
                parametro2.Value = MES;
                var parametro3 = _comandosql.Parameters.Add("@Año", SqlDbType.Int);
                parametro3.Value = AÑO;


                _adaptador.InsertCommand = _comandosql;


                _comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            //return add;
        }

        public void Asignar_Concepto(int EMPLEADO_ID, int Concepto, string Fecha)
        {
            var msg = "";
            var add = true;
            try
            {
                conectar();
                string qry = "SP_TEST_AsignarConceptos";
                _comandosql = new SqlCommand(qry, _conexion);
                _comandosql.CommandType = CommandType.StoredProcedure;
                _comandosql.CommandTimeout = 1200;

                var parametro1 = _comandosql.Parameters.Add("@Empleado", SqlDbType.Int);
                parametro1.Value = EMPLEADO_ID;
                var parametro2 = _comandosql.Parameters.Add("@Concepto", SqlDbType.Int);
                parametro2.Value = Concepto;

                Fecha = "03/01/2003";

                var parametro3 = _comandosql.Parameters.Add("@fecha", SqlDbType.Date);
                parametro3.Value = Fecha;


                _adaptador.InsertCommand = _comandosql;


                _comandosql.ExecuteNonQuery();

            }
            catch (SqlException e)
            {
                add = false;
                msg = "Excepción de base de datos: \n";
                msg += e.Message;
                MessageBox.Show(msg, "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }
            finally
            {
                desconectar();
            }

            //return add;
        }
        #endregion





    }



}

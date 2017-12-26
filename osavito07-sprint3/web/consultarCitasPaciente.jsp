<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="utils.BD"%>
<%@page import="com.mysql.jdbc.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Consultar citas</title>


        <link rel="shortcut icon" href="img/favicon.png"/>
        <link rel="stylesheet" href="css/960_24_col.css" type="text/css" />
        <link rel="stylesheet" href="css/dav-mat.css" type="text/css" media="screen"  />
        <link rel="stylesheet" href="css/estilos.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/protax-reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/snt-gmb-forms.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/snt-gmb-xtras.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/snt-login.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/snt-modulo-cajas-2.css" type="text/css" />
        <link rel="stylesheet" href="css/snts-logado.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="css/text.css" type="text/css" media="screen" />

        <script 
            type="text/javascript" src="js/borrarStorage.js">
        </script>

    </head>
    <body>
        <div id="container" class="container_24">
            <div id="logo" class="grid_4">
                <img src="img/OSAVITO.png" width="240" height="96"
                     alt="OsaVito07 Logo"/>
            </div>
            <div class="grid_20">

                <p id="tagline" style="margin-left:50px;">
                    OsaVito07 - Profesionales Sanitarios
                </p>

            </div>
            <div id="logout" class="grid_20">



                &nbsp;


            </div>
            <div id="mainmenug" class="grid_20">
                <ul>
                    <!-- Secciones -->
                    <li><a href='consultarCitasPaciente.jsp' id ='mainmenugcurrent'><span>Consultar citas</span></a></li>
                    <!-- /Secciones -->
                </ul>
            </div>
            <div class="clear"></div>
            <div id="sntmenucontent">
                <!-- Menu -->
                <div id='menu' class='grid_4'><div id='menutheme5'><ul>
                            <li><a href='index.html'>Volver a inicio (cerrar sesion)</a></li>

                        </ul></div></div> 

                <!-- /Menu -->
                <div class="grid_20">
                    <div class="sntcontent" id="contenttheme9">
                        <div id="sectioncab">
                            <h1>Administracion de OsaVito07</h1>
                        </div>
                        <div class="clear"></div>
                        <div id="contentborde">
                            <div id="webcontentcol">
                                <div class="grid_19">
                                    <h2>Consultar citas</h2>
                                    <div class="clear2"></div>

                                    <p class="form-caption">Citas pendientes</p>

                                    <table border=1>
                                        <tr>
                                            <td><strong>Fecha</strong></td>
                                            <td><strong>Hora</strong></td>
                                            <td><strong>Sanitario</strong></td>
                                            <td><strong>Tipo de Sanitario</strong></td>
                                        </tr>
                                        <%!
                                            private Connection con;
                                            private ResultSet rs;
                                            private Statement set;
                                            private ResultSet rs2;
                                            private Statement set2;

                                            public void jspInit() {
                                                con = BD.getConexion();
                                            }

                                            ;
                                        %>


                                        <div id="errores">

                                        </div>
                                        <%
                                            try {;
                                                Date ahora = new Date();
                                                SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
                                                formateador.format(ahora);
                                                String fecha;
                                                String hora;
                                                String medico;
                                                String tipoSanitario;
                                                String tis = (String) session.getAttribute("tis");
                                                set = con.createStatement();
                                                rs = set.executeQuery("SELECT citas.fecha, citas.hora, sanitarios.nombre, sanitarios.tipoSanitario FROM citas NATURAL JOIN sanitarios WHERE citas.tis='" + tis + "' AND citas.fecha > now()");
                                                while (rs.next()) {
                                                    fecha = rs.getString("fecha");
                                                    hora = rs.getString("hora");
                                                    medico = rs.getString("nombre");
                                                    tipoSanitario = rs.getString("tipoSanitario");
                                        %>     

                                        <% if (tipoSanitario.equals("ME")) {
                                                tipoSanitario = "Medico/a";
                                            } else if (tipoSanitario.equals("EN")) {
                                                tipoSanitario = "Enfermero/a";
                                            } else {
                                                tipoSanitario = "Matron/a";
                                            }
                                        %>
                                        <tr>
                                            <td><%= fecha%></td>
                                            <td><%= hora%></td>
                                            <td><%= medico%></td>
                                            <td><%= tipoSanitario%></td>
                                        </tr>
                                        <%
                                                }
                                                rs.close();
                                                set.close();
                                                //con.close();
                                            } catch (Exception e) {
                                                System.out.println("Error en acceso a BD Jugadores");
                                            }
                                        %>
                                    </table>

                                    <p class="form-caption">Citas pasadas</p>

                                    <table border=1>
                                        <tr>
                                            <td><strong>Fecha</strong></td>
                                            <td><strong>Hora</strong></td>
                                            <td><strong>Sanitario</strong></td>
                                            <td><strong>Tipo de Sanitario</strong></td>
                                        </tr>

                                        <div id="errores">

                                        </div>
                                        <%
                                            try {;
                                                Date ahora = new Date();
                                                SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
                                                formateador.format(ahora);
                                                String fecha;
                                                String hora;
                                                String medico;
                                                String tipoSanitario;
                                                String tis = (String) session.getAttribute("tis");
                                                set2 = con.createStatement();
                                                rs2 = set2.executeQuery("SELECT citas.fecha, citas.hora, sanitarios.nombre, sanitarios.tipoSanitario FROM citas NATURAL JOIN sanitarios WHERE citas.tis='" + tis + "' AND citas.fecha < now()");
                                                while (rs2.next()) {
                                                    fecha = rs2.getString("fecha");
                                                    hora = rs2.getString("hora");
                                                    medico = rs2.getString("nombre");
                                                    tipoSanitario = rs2.getString("tipoSanitario");
                                        %>     

                                        <% if (tipoSanitario.equals("ME")) {
                                                tipoSanitario = "Medico/a";
                                            } else if (tipoSanitario.equals("EN")) {
                                                tipoSanitario = "Enfermero/a";
                                            } else {
                                                tipoSanitario = "Matron/a";
                                            }
                                        %>
                                        <tr>
                                            <td><%= fecha%></td>
                                            <td><%= hora%></td>
                                            <td><%= medico%></td>
                                            <td><%= tipoSanitario%></td>
                                        </tr>
                                        <%
                                                }
                                                rs2.close();
                                                set2.close();
                                                //con.close();
                                            } catch (Exception e) {
                                                System.out.println("Error en acceso a BD Jugadores");
                                            }
                                        %>
                                    </table>

                                    <div class="clear2"></div>
                                    <div class="action_buttons center">
                                        <input id="btnok" name="botonOK" value="Volver" class="btngo" type="button" onclick="location = 'asignarOCancelar.html'"/>
                                    </div>
                                    <div style="display: none;"><input type="hidden" name="_sourcePage" value="Roo1ruVK35-_j34lwgxH4cto8i3O-iSEVbJbAJjhZ062li6LzStSNXkpuP8C7g_ugNY3hubWgMUMxqT-BzMnKO32RTMYkt3yTAxYYDPX1zlx-nK7QuuFIw==" /><input type="hidden" name="__fp" value="5ZDrEucaBneZdHKsx-55JM4dv6jAVsx0xztX8W8FUq4YftCat4h8e8yFfX2TRVBBc9InxRh21EcbPevbNIFlpU189e7WB1vxKd9s0KUzmK076YdkRnveIpCZs1oPODf14hcHjw0k-_yYNHBvq6eHv9WgI8NVlLz3J0eYlqbTXg4qP3G35c6buwZRfsH4r7oHI2SF7NFtMKu-MqYBErQT8ev-73rBceh9rZC9AdMTnMnslFzUpngrguWg0fNe-GXWD4yCzXXf05CyQMe__1DvuZPA-HO01sTnJ5XgybhSylFuWz8fHecvuI9Cf7vKOlxmShbXyw8pWaOLGBDHWQipOpi5CnbqWgl8U7qaU8xg7BSSp0gARsIUIA==" /></div>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div id="footer" class="grid_20">
                        <p>


                            <a target="_blank" href="http://www.ehu.eus"><span class="pie">UPV/EHU</span></a>
                            | 2017 &copy Grupo07 ADSI
                        <div id="logobottom" class="grid_4">
                            <img src="img/DENKOL.png" width="160" height="100"
                                 alt="DENKOL Logo" style="margin-left:325px; margin-top:-10px"/>
                        </div>

                        <p><span class="pie">&nbsp;</span></p>
                    </div>
                    </html>


<%@page import="utils.BD"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
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

                                <form name="formDatos" id="formDatos" class="js-form-validation form-type-a" method="get">
                                    <div id="errores">

                                    </div>
                                    
                                    <!--Listar aqui las citas mediante codigo java en el jsp y servlets como en el ejercicio del futbol.
                                    -->
                                    <%
                                        String fecha = (String) session.getAttribute("fechaCitas");
                                    %>
                                    Dia: <%=fecha%>
                                    <br>
                                    <br/>
                                    
                                    <table border=1>
                                        <tr>
                                            <td><strong>Hora</strong></td>
                                            <td><strong>TIS Paciente</strong></td>
                                            <td><strong>Nombre del paciente</strong></td>
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
                                                String hora;
                                                String tisPac;
                                                String nombrePac;
                                                String numColegiado = (String) session.getAttribute("numColegiado");
                                                set = con.createStatement();
                                                rs = set.executeQuery("select citas.tis, citas.hora, pacientes.nombre from citas NATURAL JOIN pacientes WHERE citas.numColegiado = '"+ numColegiado +"' AND citas.fecha = '" + fecha + "';");
                                                while (rs.next()) {
                                                    hora = rs.getString("hora");
                                                    tisPac = rs.getString("tis");
                                                    nombrePac = rs.getString("nombre");
                                        %> 
                                        <tr>
                                            <td><%=hora%></td>
                                            <td><%=tisPac%></td>
                                            <td><%=nombrePac%></td>
                                        </tr>
                                        <%
                                                }
                                                rs.close();
                                                set.close();
                                                //con.close();
                                            } catch (Exception e) {
                                                System.out.println("Error en acceso a BD");
                                            }
                                        %>
                                    </table>

                                    
                                    <div class="clear2"></div>
                                    <div class="action_buttons center">
                                        <input id="btnok" name="botonOK" value="Volver" class="btngo" type="button" onclick="location='consultarCitasSanitario.jsp'"/>
                                    </div>
                                    <div style="display: none;"><input type="hidden" name="_sourcePage" value="Roo1ruVK35-_j34lwgxH4cto8i3O-iSEVbJbAJjhZ062li6LzStSNXkpuP8C7g_ugNY3hubWgMUMxqT-BzMnKO32RTMYkt3yTAxYYDPX1zlx-nK7QuuFIw==" /><input type="hidden" name="__fp" value="5ZDrEucaBneZdHKsx-55JM4dv6jAVsx0xztX8W8FUq4YftCat4h8e8yFfX2TRVBBc9InxRh21EcbPevbNIFlpU189e7WB1vxKd9s0KUzmK076YdkRnveIpCZs1oPODf14hcHjw0k-_yYNHBvq6eHv9WgI8NVlLz3J0eYlqbTXg4qP3G35c6buwZRfsH4r7oHI2SF7NFtMKu-MqYBErQT8ev-73rBceh9rZC9AdMTnMnslFzUpngrguWg0fNe-GXWD4yCzXXf05CyQMe__1DvuZPA-HO01sTnJ5XgybhSylFuWz8fHecvuI9Cf7vKOlxmShbXyw8pWaOLGBDHWQipOpi5CnbqWgl8U7qaU8xg7BSSp0gARsIUIA==" /></div></form>
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

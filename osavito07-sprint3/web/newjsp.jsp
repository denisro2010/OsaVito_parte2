<%-- 
    Document   : newjsp
    Created on : 26-dic-2017, 18:30:55
    Author     : D
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String tis = (String) session.getAttribute("tis"); 
               String numColegiado = (String) session.getAttribute("numColegiado"); 
String tiposani = (String) session.getAttribute("tipoSanitario");
            %>
        </table>
        <h3>tis: <%=tis %>, numColegiado: <%=numColegiado %>, tipo: <%=tiposani %></h3>
    </body>
    </body>
</html>

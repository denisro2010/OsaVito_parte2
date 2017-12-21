/* 
 * VAMOS A USAR ESTO PARA LOS LOGIN DEL SPRINT 2 & 3
 */
function go(){
    var usr=document.getElementById("usuario");
    var clv=document.getElementById("clave");
if (usr.value==="admin" && clv.value==="admin"){ 
        location.href="altaSanitarios.html";
    } 
    else{ 
         alert("El nombre de usuario o la clave no son correctos. Pruebe de nuevo."); 
    } 
} 



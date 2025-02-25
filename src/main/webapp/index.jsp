<%@ page import="java.sql.*, javax.sql.* " %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Boa Cama & Boa Mesa</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        String erro = "";
        if(request.getParameter("criar_conta") != null){
            erro ="<p style='color:green; text-align:center;'>*Account created! </p>";
        }
        if(request.getParameter("login") != null){
            System.out.println("login clicado");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println("Email" + email);
            System.out.println("Password" + password);

            if(email == null || password == null){
                System.out.println("Erro: Parâmetros não foram recebidos corretamente.");
            }

            try{
                if(email.isEmpty() || password.isEmpty()){
                    erro = "<p style='color:red; text-align:center;'>*All fields must be filled!!</p>";
                } else {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/java_37","root","");
                    String consulta = "select * from login where email ='" +email + "' and password = '" + password + "'";
                    Statement st = con.createStatement();
                    ResultSet resultado = st.executeQuery(consulta);

                    if(resultado.next()){
                        System.out.print("Aqui chega");
                        response.sendRedirect("reservas.jsp");
                    }
                }
            } catch (Exception e) {
                erro = "<p style='color:red; text-align:center;'>*Por favor, contacte o administrador!!</p>";
            }
        }


    %>
<div class="container-fluid d-flex vh-100">
    <div class="fundoTela">
        <img src="img/room1.jpeg" class="img-room">
    </div>

    <div class="loginContainer d-flex align-items-center justify-content-center">
        <div class="loginBox">
            <h2>Welcome!</h2>
            <p>Faça login para continuar</p>
            <form class="card-body cardbody-color p-lg-5" method="post" action="reservas.jsp">
                <div class="mb-3">
                    <label for="email" class="form-label">E-mail</label>
                    <input type="email" id="email" class="form-control" name="email" placeholder="Digite seu e-mail">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" class="form-control" name="password" placeholder="Digite sua senha">
                </div>
                <button type="submit" class="btn golden w-100" name="login">Entrar</button>
                <div class="mb-3 text-center">
                    <a href="criar_conta.jsp" target="_blank"> Criar Conta</a>
                </div>
                <div class="mb-3 text-center">
                    <%  out.print(erro);  %>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>


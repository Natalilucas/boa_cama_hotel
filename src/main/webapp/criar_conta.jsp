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
    if (request.getParameter("criarConta") != null) {
    String nome = request.getParameter("username");
    String senha = request.getParameter("password");
    String senha1 = request.getParameter("repassword");
    String email = request.getParameter("email");

    try {
    if (nome.isEmpty() || senha.isEmpty()) {
        erro = "<p style='color:red; text-align:center;'>*Os campos são de preenchimento obrigatório!!</p>";
    } else {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/java_37","root","");
        String consulta = "select * from clientes where nome = '" + nome + "' and senha = '" + senha + "'";
        Statement st = con.createStatement();
        ResultSet resultado = st.executeQuery(consulta);

        if(resultado.next() == true) {
            erro = "<p style='color:red; text-align:center;'>*Utilizador e/ou password errados!!</p>";
        } else {
        String inserir = "insert into clientes (nome, senha, email) values ('" + nome + "', '" + senha + "', '" + email + "')";
        Statement stInserir = con.createStatement();
        int resposta = stInserir.executeUpdate(inserir);
        if( resposta > 0 ){
            erro = "<p style='color:green; text-align:center;'>*Conta criada com sucesso!</p>";
        } else {
            erro = "<p style='color:red; text-align:center;'>*Algo correu mal, por favor contacte o Admin!</p>";
        }
    }
    }
    } catch (Exception e) {
        erro = "<p style='color:red; text-align:center;'>*Por favor, contacte o administrador!!</p>";
    }
    }
    %>

<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <h2 class="text-center text-dark mt-5">Crie sua conta</h2>
            <div class="card my-5">

                <form class="card-body cardbody-color p-lg-5" method="POST" action="criar_conta.jsp">

                    <div class="text-center">
                        <img src="https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397__340.png" class="img-fluid profile-image-pic img-thumbnail rounded-circle my-3"
                             width="200px" alt="profile">
                    </div>

                    <div class="mb-3">
                        <input type="text" class="form-control" name="username" aria-describedby="emailHelp" placeholder="Nome">
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password">
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" name="repassword" placeholder="Re-Password">
                    </div>
                    <div class="mb-3">
                        <input type="email" class="form-control" name="email" placeholder="E-Mail">
                    </div>
                    <div class="text-center"><button type="submit" name="criarConta" class="btn golden px-5 mb-5 w-100"> CRIAR CONTA </button></div>

                    <div class="mb-3 text-center">
                        <%  out.print(erro);  %>
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>
</body>
</html>


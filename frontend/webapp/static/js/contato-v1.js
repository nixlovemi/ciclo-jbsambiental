function validate_mail(mail) {
  if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
    return true;
  }
  return false;
}

function contact_success() {
  alert("Mensagem enviada com sucesso!");
}

function contact_error(jqXHR, exception) {
  if (jqXHR.status != 200) {
    alert("Erro ao enviar mensagem. Tente novamente mais tarde!");
  } else {
    contact_success();
  }
}

function contact_complete(jqXHR, exception) {
  $('#contato-enviar').html("Enviar Mensagem");
  $('#contato-enviar').click( function(e) {e.preventDefault(); contact_form(); return false; } );
}

function contact_form() {
  var nome = $("#nome").val().trim();
  var email = $("#email").val().trim();
  var telefone = $("#telefone").val().trim();
  var mensagem = $("#mensagem").val().trim();
  var privacidade = $("#privacidade-check").is(":checked")

  if (nome === "") {
    alert("O campo Nome precisa ser preenchido.")
    return;
  }

  if (email === "") {
    alert("O campo E-mail precisa ser preenchido.")
    return;
  }

  if (! validate_mail(email)) {
    alert("E-mail precisa ser preenchido corretamente.")
    return;
  }

  if (telefone === "") {
    alert("O campo Telefone precisa ser preenchido.")
    return;
  }

  if (mensagem === "") {
    alert("O campo Mensagem precisa ser preenchido.")
    return;
  }

  if (! privacidade) {
    alert("Você precisa aceitar os termos da Política de Privacidade para poder enviar essa mensagem.")
    return;
  }

  data = {
    "nome": nome,
    "email": email,
    "telefone": telefone,
    "mensagem": mensagem
  };

  // double click prevention
  $('#contato-enviar').html("Enviando...");
  $('#contato-enviar').off("click");

  $.ajax({
    type: "POST",
    contentType: "application/json; charset=utf-8",
    url: "/mail",
    data: JSON.stringify(data),
    dataType: "json",
    success: contact_success,
    error: contact_error,
    complete: contact_complete
  });
}

$( document ).ready(function() {
  $('#contato-enviar').click( function(e) {e.preventDefault(); contact_form(); return false; } );
});

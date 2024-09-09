$(document).ready(function() {
  // Toggle do conteúdo do card
  $('.fa-plus').click(function() {
      var $cardBody = $(this).closest('.card').find('.card-body');
      $cardBody.toggle();
      $(this).toggleClass('fa-plus fa-minus');
  });

  // Inicializa o EmailJS
  emailjs.init("tcIQ-MEIxI6wOTrBg");

  // Configura o envio do formulário
  $('#contact-form').on('submit', function(event) {
      event.preventDefault();
      emailjs.sendForm('service_aeu1pvh', 'template_hb4ic34', this)
          .then(() => {
              console.log('SUCCESS!');
              return Swal.fire('Boa!', 'E-mail enviado com sucesso!', 'success');
          })
          .then(() => {
              // Limpa o formulário após a mensagem de sucesso ser fechada
              $('#contact-form')[0].reset();
          })
          .catch((error) => {
              console.log('FAILED...', error);
              Swal.fire('Ops...', 'Algo deu errado, tente novamente!', 'error');
          });
  });
});
$(document).ready(function(){
    $('.fa-plus').click(function(){
      var $cardBody = $(this).closest('.card').find('.card-body');
      $cardBody.toggle();
      $(this).toggleClass('fa-plus fa-minus');
    });
  });
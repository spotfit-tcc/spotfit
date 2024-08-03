var swiper = new Swiper(".mySwiper", {
    navigation: {
      nextEl: ".professional-service-slider--button-next",
      prevEl: ".professional-service-slider--button-prev",
    },
    pagination: {
      el: ".professional-service-slider--pagination",
    },
    keyboard: true,
    loop: true
});

var plan_swiper = new Swiper(".plans-swiper", {
  slidesPerView: "auto",
  spaceBetween: 30,
  loop: true,

  navigation: {
      nextEl: ".lp-control-swiper-categorie-button-next",
      prevEl: ".lp-control-swiper-categorie-button-prev",
    },
});
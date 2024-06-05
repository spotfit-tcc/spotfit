window.onload = (event) => {
    var swiper = new Swiper(".lp-categories-swiper", {
        slidesPerView: "auto",
        spaceBetween: 30,
        loop: true,

        navigation: {
            nextEl: ".lp-control-swiper-categorie-button-next",
            prevEl: ".lp-control-swiper-categorie-button-prev",
          },
    });
};
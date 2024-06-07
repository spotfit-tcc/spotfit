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
    var swiper2 = new Swiper(".lp-testemonial-swiper", {
        slidesPerView: "auto",
        spaceBetween: 30,
        loop: true,
        navigation: {
            nextEl: ".lp-control-swiper-testemonial-button-next",
            prevEl: ".lp-control-swiper-testemonial-button-prev",
          },
    });
};
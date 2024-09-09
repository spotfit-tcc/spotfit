
var swiperCategories = new Swiper('.lp-categories-swiper', {
    slidesPerView: 'auto',
    spaceBetween: 20,
    autoplay: {
        delay: 3000,
        disableOnInteraction: false,
    },
    speed: 2000,
    navigation: {
        nextEl: '.lp-control-swiper-categorie-button-next',
        prevEl: '.lp-control-swiper-categorie-button-prev',
    },
    loop: true,
    breakpoints: {
        1024: {
            slidesPerView: 4,
        },
        768: {
            slidesPerView: 3,
        },
        480: {
            slidesPerView: 2,
        },
    },
});

var swiperTestemonials = new Swiper('.lp-testemonial-swiper', {
    slidesPerView: 'auto',
    spaceBetween: 20,
    autoplay: {
        delay: 5000,
        disableOnInteraction: false,
    },
    speed: 5000,
    navigation: {
        nextEl: '.lp-control-swiper-testemonial-button-next',
        prevEl: '.lp-control-swiper-testemonial-button-prev',
    },
    loop: true,
    breakpoints: {
        1024: {
            slidesPerView: 2,
        },
        768: {
            slidesPerView: 1,
        },
        480: {
            slidesPerView: 1,
        },
    },
});

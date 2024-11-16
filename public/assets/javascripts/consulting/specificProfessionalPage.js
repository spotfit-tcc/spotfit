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

document.addEventListener('DOMContentLoaded', function() {
  const stars = document.querySelectorAll('.rating-icon');
  const ratingInput = document.getElementById('comment_rating');
  const commentInput = document.getElementById('comment_description');
  const errorMessage = document.getElementById('error-message');
  const form = document.getElementById('ratingForm');

  // Event listeners for stars to set rating
  stars.forEach(star => {
      star.addEventListener('click', function() {
          const ratingValue = this.getAttribute('data-value');
          ratingInput.value = ratingValue;
          updateStars(ratingValue);
      });

      star.addEventListener('mouseover', function() {
          const hoverValue = this.getAttribute('data-value');
          updateStars(hoverValue);
      });

      star.addEventListener('mouseout', function() {
          updateStars(ratingInput.value);
      });
  });

  // Function to update the visual state of the stars
  function updateStars(value) {
      stars.forEach(s => {
          if (s.getAttribute('data-value') <= value) {
              s.classList.add('checked');
          } else {
              s.classList.remove('checked');
          }
      });
  }

  // Form submission event to validate input
  form.addEventListener('submit', function(event) {
      const ratingValue = ratingInput.value;
      const commentText = commentInput.value.trim();

      // Check if both rating and comment are provided
      if (!ratingValue || !commentText) {
          event.preventDefault(); // Prevent form from submitting
          errorMessage.textContent = "Por favor, forneça uma classificação e um comentário.";
          errorMessage.style.display = "block";
      } else {
          errorMessage.style.display = "none"; // Hide error message if inputs are valid
      }
  });
});

function redirectToWhatsApp(phoneNumber) {
  const url = `https://wa.me/${phoneNumber}`;
  window.open(url, '_blank');
}

document.getElementById('scheduleContactButton').onclick = function() {
    document.getElementById('scheduleContactModal').style.display = 'block';
};
document.getElementById('closeModal').onclick = function() {
    document.getElementById('scheduleContactModal').style.display = 'none';
};

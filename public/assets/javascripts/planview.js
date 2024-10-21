var stripe = Stripe('pk_test_51Q9Dl6RxE3ZgGCwMLjbCz8VlKWSVWhDehKoBpFPzYu8cfNcHNXMyVxkyzjPcHolJcCmwhfL0Vnbe445jgZioTHNz00LK7PLF1q');  // Chave pública do Stripe

function redirectToStripe(plan) {
    fetch('/planview/checkout', {  
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'plan=' + plan  
    })
    .then(function (response) {
        return response.json();
    })
    .then(function (session) {
        // Redireciona para a página de checkout do Stripe
        return stripe.redirectToCheckout({ sessionId: session.id });
    })
    .then(function (result) {
        if (result.error) {
            alert(result.error.message);
        }
    })
    .catch(function (error) {
        console.error('Error:', error);
    });
}

// Evento para o botão do Plano Grátis
document.querySelector('.btn-free').addEventListener('click', function() {
    window.location.href = '/sign_up'; 
});

// Evento para o botão do Plano Pro
document.querySelector('.btn-pro').addEventListener('click', function() {
    redirectToStripe('pro');  
});

// Evento para o botão do Plano Premium
document.querySelector('.btn-premium').addEventListener('click', function() {
    redirectToStripe('premium');  
});

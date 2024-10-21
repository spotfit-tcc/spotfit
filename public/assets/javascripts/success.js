async function initialize() {
  // Obtém o session_id da URL
  const queryString = window.location.search;
  const urlParams = new URLSearchParams(queryString);
  const sessionId = urlParams.get('session_id');

  if (!sessionId) {
    console.error('Session ID not found in the URL');
    return;
  }

  const response = await fetch("/get-session-status", {  
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    method: "POST",
    body: JSON.stringify({ session_id: sessionId }), 
  })

  const session = await response.json();

  // Exibe as informações de sucesso se a sessão for válida
  if (session) {
    document.getElementById('success').classList.remove('hidden');
    document.getElementById('customer-email').textContent = session.customer_email;
  } else {
    console.error('Session not found or invalid');
  }
}

// Chama a função de inicialização ao carregar a página
initialize();

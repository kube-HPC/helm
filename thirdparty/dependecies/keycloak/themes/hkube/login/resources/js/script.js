(() => {
  setTimeout(() => {
    const usernameInput = document.querySelector("#username");
    const passwordInput = document.querySelector("#password");

    if (usernameInput && passwordInput) {
      usernameInput.setAttribute("placeholder", "Username");
      passwordInput.setAttribute("placeholder", "Password");
    }
  }, 500);
})();

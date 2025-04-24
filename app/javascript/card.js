const pay = () => {
  const publickey = gon.public_key;
  const payjp = Payjp(publickey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // ← 最初にprevent！

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        console.log("カード情報が正しく入力されていません");
        // ここであえてそのまま submit して、token: nil の状態でRailsに渡す
        form.submit();
      } else {
        const token = response.id;
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        form.submit();
      }
    
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
    });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);

const price = () => {
  const priceInput = document.getElementById("item-price");
  const taxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const value = parseInt(priceInput.value, 10);


    if (isNaN(value)) {
      taxPrice.textContent = "0";
      profit.textContent = "0";
      return;
    }


    const tax = Math.floor(value * 0.1);
    const net = value - tax;

    taxPrice.textContent = tax.toLocaleString();
    profit.textContent = net.toLocaleString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render",price);
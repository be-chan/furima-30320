function price (){
 const itemPrice = document.getElementById("item-price");
 itemPrice.addEventListener("input", () => {
  const inputValue = itemPrice.value;

  const addTaxPrice = document.getElementById("add-tax-price");
  addTaxPrice.innerHTML = (Math.floor(inputValue * 0.1));

  const Profit = document.getElementById("profit");
  const inputValueMinus = inputValue * 0.1
  Profit.innerHTML = (Math.floor(inputValue - inputValueMinus));
 });
}

window.addEventListener('load', price);
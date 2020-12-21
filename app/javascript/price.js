function price (){
 const itemPrice = document.getElementById("item-price");
 itemPrice.addEventListener("input", () => {
  const inputValue = itemPrice.value;
  console.log(inputValue);

  const addTaxPrice = document.getElementById("add-tax-price");
  addTaxPrice.innerHTML = (Math.floor(inputValue * 0.1));
  console.log(addTaxPrice);

  const Profit = document.getElementById("profit");
  const inputValueMinus = inputValue * 0.1
  console.log(inputValueMinus)
  Profit.innerHTML = (Math.floor(inputValue - inputValueMinus));
  console.log(Profit)
 });
}

window.addEventListener('load', price);
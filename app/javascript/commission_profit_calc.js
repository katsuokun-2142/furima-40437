function commission_profit_calc (){
  const item_price = document.getElementById('item-price')
  console.log(item_price)
  const tax = 0.1
  item_price.addEventListener('keyup',(e)=>{
    const value = item_price.value
    console.log(value)
    // 販売手数料
    let commission = Math.floor(value * tax)
    const add_tax_price = document.getElementById('add-tax-price')
    add_tax_price.innerHTML = commission
    // 販売利益
    let profit = Math.floor(value - commission)
    const profit_price = document.getElementById('profit')
    profit_price.innerHTML = profit
  })
};

window.addEventListener('turbo:load', commission_profit_calc);
 
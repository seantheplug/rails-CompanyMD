var content =
  `<a href="#">
    <div class="basket-card">
      <p class="text-truncate">NEW GROUP</p>
      <p>0</p>
      <i class="fas fa-eye"></i>
    </div>
  </a>`

var addNewPortfolio = (content) => {
  console.log("hello oooo");
  var sideBar = document.querySelector(".basket-cards");
  sideBar.insertAdjacentHTML('beforeend', content);
};
const plusSign = document.getElementById("add-group");
plusSign.addEventListener("click", (event) => { addNewPortfolio(content) });

let newPortfolioContent =

  `<div style="display: inline-block">
    <a href="#">
      <div class="basket-card">
        <p class="text-truncate nameToChangeField">New Portfolio</p>
        <p>0</p>
      </div>
    </a>
    <div class="item-control">
      <i class="fas fa-pencil-alt edit nameToAdd" style="background-color: pink">
    </div>
  </div>`;

var addNewPortfolio = (content) => {
  var sideBar = document.querySelector(".basket-cards");
  sideBar.insertAdjacentHTML('beforeend', content);
  callMeBitch()
};
const plusSign = document.getElementById("add-group");
plusSign.addEventListener("click", (event) => { addNewPortfolio(newPortfolioContent) });

var nameContent =
  `<form action="/groups" method="post" id="new_group">
    <input type="hidden" name="authenticity_token" value="${plusSign.dataset.token}">
    <input type="text" name="group[name]" for="group_name" id="group_name" placeholder="A New Name">
  </form>`;


let callMeBitch = () => {
  var addGroupName = (nameContent) => {
    let nameSpace = event.target.parentNode.querySelector('.nameToChangeField');
    event.target.parentNode.innerHTML = nameContent;
  };
  let addPencils = document.querySelectorAll(".nameToAdd");
  addPencils.forEach((pencil) => {
    pencil.addEventListener("click", (event) => {addGroupName(nameContent) });
  });
};

callMeBitch()

let updateNameContent = (group) => {
  let name = event.target.parentNode.querySelector('.nameToChangeField');
  let updatedPortfolioContent =

  `<form action="/groups/${group}" method="post" id="edit_group_${group}">
    <input type="hidden" name="authenticity_token" value="${plusSign.dataset.token}">
    <input type="hidden" name="_method" value="patch">
    <input type="text" name="group[name]" for="group_name" id="group_name" placeholder="A New Name">
  </form>`;
  event.target.parentNode.innerHTML = updatedPortfolioContent;
};

let changePencils = document.querySelectorAll(".nameToChange");
changePencils.forEach((pencil) => {
  var groupValue = pencil.dataset.group
  pencil.addEventListener("click", (event) => {updateNameContent(groupValue) });
});


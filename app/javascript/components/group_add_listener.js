// The below targets the sidebar and adds an unsaved group with a generic name

var content =

  `<a href="#">
    <div class="basket-card">
      <p class="text-truncate nameToChange">2click to edit</p>
      <p>0</p>
      <i class="fas fa-eye"></i>
    </div>
  </a>`

var addNewPortfolio = (content) => {
  var sideBar = document.querySelector(".basket-cards");
  sideBar.insertAdjacentHTML('beforeend', content);
  callMeBitch()
};
const plusSign = document.getElementById("add-group");
plusSign.addEventListener("click", (event) => { addNewPortfolio(content) });


//

var nameContent =
  `<form action="/groups" method="post" id="new_group">
    <input type="hidden" name="authenticity_token" value="${plusSign.dataset.token}">
    <input type="text" name="group[name]" for="group_name" id="group_name" placeholder="A New Name">
  </form>`;


let callMeBitch = () => {
  var changeGroupName = (nameContent) => {
    event.target.innerHTML = nameContent;
  };
  let nameSpace = document.querySelector(".nameToChange");
  console.log(nameSpace)
  nameSpace.addEventListener("dblclick", (event) => {changeGroupName(nameContent) });
}

callMeBitch()


// submit it with the name= authenticity_token value= 'the value I get from the data'

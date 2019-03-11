const initLoader=() => {
  // find button
  const button = document.getElementById("location_find");
  // find both divs on the new page
  const searchPage = document.getElementById("new_page");
  const loader = document.getElementById("loader");
  const navBar = document.getElementById("navbar-loader");

  // add event listener to button
  button.addEventListener("click", () => {
    console.log("hi");
    searchPage.classList.add("hidden");
    loader.classList.remove("hidden");
    navBar.classList.add("hidden");
  });
  // add class and remove class form both respectively

  // window.addEventListener("load", () => {
  //   navBar.classList.remove("hidden");
  // });
};


export { initLoader };

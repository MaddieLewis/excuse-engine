const initLoader=() => {
  // find button
  const button = document.getElementById("location_find");
  // find both divs on the new page
  const searchPage = document.getElementById("new_page");
  const loader = document.getElementById("loader");
  const navBar = document.getElementById("navbar-loader");
  const form = document.getElementById("new_location_excuse");
  const staticLoader = document.getElementById("static-loader")
  // const hammer = new Hammer(button, {domEvents: true});
  // var tap = new Hammer.Tap();
  // mc.add(tap);
  // add event listener to button

  // $('#new_location_excuse').on("submit", () => {
  //   $("#new_page, #navbar-loader").addClass("hidden");
  //   $("#loader").removeClass("hidden");
  // });

  // $('#location_find').on("tap", () => {
  //   // $("#new_page, #navbar-loader").addClass("hidden");
  //   $("#loader").removeClass("hidden");
  // });


  if (form) {
    form.addEventListener("submit", (event) => {
      event.preventDefault();
      searchPage.classList.add("hidden");
      staticLoader.classList.remove("hidden");
      navBar.classList.add("hidden");
      setTimeout(() => {
        form.submit();
      }, 500);

    });
  }

  // add class and remove class form both respectively

  // window.addEventListener("load", () => {
  //   navBar.classList.remove("hidden");
  // });
};


export { initLoader };

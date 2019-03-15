const tooltip = () => {
  const copy = document.getElementById('copy-button');
  if (copy) {
    copy.addEventListener('click', (event) => {
      const newValue = "Copied"
      $('[data-toggle="tooltip"]').tooltip()
              .attr('data-original-title', newValue)
              .tooltip('update')
              .tooltip('hide')
              .tooltip('show');
    })
  }
}
export { tooltip };


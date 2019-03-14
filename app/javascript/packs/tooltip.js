const tooltip = () => {
  document.getElementById('copy-button').addEventListener('click', (event) => {
    const newValue = "Copied"
    $('[data-toggle="tooltip"]').tooltip()
            .attr('data-original-title', newValue)
            .tooltip('update')
            .tooltip('hide')
            .tooltip('show');
  })
}
export { tooltip };


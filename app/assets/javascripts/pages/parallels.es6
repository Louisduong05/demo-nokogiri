DemoNokogiri.parallels = {
  parallelrate: {
    init: function() {
      const item = $("a.saveValueParallels")
      item.click(() => {
        console.log(item.find("td"));
      })
    }
  }
}
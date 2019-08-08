DemoNokogiri.parallels = {
  parallelrate: {
    init: function() {
      $("a.save-currency").click(function() {
        const data_rate = $(this).data()
        console.log(data_rate.date);
        Rails.ajax({
          url: "/parallels",
          type: "POST",
          dataType: "JSON",
          data: {
            rate: {
              "date": data_rate.date,
              "rates_usd": data_rate.usd,
              "rates_eur": data_rate.eur,
              "rates_gbp": data_rate.gbp
            }
          },
          success: function(data) {
            alert("Save succesfuly")
          },
          error: function(data) {
            console.log(data)
            alert("Don't save")
          }
        })
      })
    }
  }
}
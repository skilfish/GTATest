var broker = {
    firsttime : false,
    lasttabopen: "#broker-home",
    tabopen: "#broker-home",
    footer: {},
    home : {},
    stocks : {
        
    },
    exchange: {
        amount: null,
        name: null
    },
    stock: {
        openprice: null,
        openname: null,
    },
    mystock: {
        openprice: null
    },
    user : {}
}

currency = "$"

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "broker" && v.task == "iconstate") {
            broker.Icon(v.state)
        }

        if (v.app == "broker" && v.task == "loadhome") {
            broker.home.load(v.html)
        } else if (v.app == "broker" && v.task == "setwalletworth") {
            broker.home.setwalletworth(v.walletworth, v.changetext, v.change2)
        } else if (v.app == "broker" && v.task == "drawhomegraph") {
            broker.home.Refreshusergraph(v.data)
        }  else  if (v.app == "broker" && v.task == "hidegraph") {
            $("#broker-home-graphcoumn").hide(0)
            $("#broker-stock-graphcoumn").hide(0)
        }

        if (v.app == "broker" && v.task == "loadstocks") {
            broker.stocks.load(v.html)
        } else if (v.app == "broker" && v.task == "loadstockgraph") {
            broker.stock.loadChart(v.data)
        } 

        if (v.app == "broker" && v.task == "loadhistory") {
            broker.user.load(v.html, v.bought, v.sold)
        } 
        
    })
});

broker.Icon = function(state) {
    if (state == true) $("#stockicon").show(0)
    if (state == false) $("#stockicon").hide(0)
}

broker.show = function() {
    ShowHomebar()
    $("#broker").animate({
        "left": "0%"
    })
    Main.openapp = "broker"
}

broker.home.load = function(html) {
    $(".broker-home-elements").html("")
    $(".broker-home-elements").append(html)

    $(".broker-exchange-elements").html("")
    $(".broker-exchange-elements").append(html)



    var $wrapper = $('.broker-home-elements');

    $wrapper.find('.broker-home-element').sort(function(a, b) {
        return +b.getAttribute('data-worth') - +a.getAttribute('data-worth');
    })
    .appendTo($wrapper);

    var $wrapper2 = $('.broker-exchange-elements');

    $wrapper2.find('.broker-home-element').sort(function(a, b) {
        return +b.getAttribute('data-worth') - +a.getAttribute('data-worth');
    })
    .appendTo($wrapper2);
}     

broker.home.setwalletworth = function(walletworth, changetext, change2) {
    $("#broker-home-walletworth").html(walletworth)
    $("#broker-home-walletworth-change").html(changetext)

    if (change2 == 0) {
        $("#broker-home-walletworth-change").removeClass("greencolor")
        $("#broker-home-walletworth-change").addClass("redcolor")
    } else {
        $("#broker-home-walletworth-change").addClass("greencolor")
        $("#broker-home-walletworth-change").removeClass("redcolor")
    }
}

var brokerfirsttime = true
var brokermyChart

var firstDate = null
var lastDate = null
var lastDate2 = null
broker.home.Refreshusergraph = function(Data)  {
    var newData = []

    if (brokerfirsttime == true)  {
        $.each( Data, function( key, value ) {
            var obj1 = value.x
            var obj2 = value.y

            newData.push({
                x: new Date(obj1),
                y: obj2
            })
            if (firstDate === null) {firstDate = new Date(obj1)}
            lastDate = new Date(obj1)
            lastDate2 = new Date(obj1)
        });
        var ctx = document.getElementById('brokerhomeChart').getContext('2d');
        brokermyChart = new Chart(ctx, {
            type: 'line',
            data: {
                // labels: TimeData,
                datasets: [{
                    label: "Bitcoin in $",
                    data: newData,
                    backgroundColor: [

                        'rgba(0, 255, 0, 0.1)'
                    ],
                    borderColor: [
                        'rgba(0, 255, 0, 1)'
                    ],
                    borderWidth: 1.5,
                    fill: true, 
                    tension: 0.2,
                    pointHoverRadius: 10,
                },
            ]
            },
            options: {
                bezierCurve : true,
                responsive: false,
                maintainAspectRatio: true,
                scales: {
                    y: {
                        display: false,
                        beginAtZero: false
                    },
                    x: {
                        // display: true,
                        min: firstDate,
                        max: lastDate,
                        type: "time",
                        time: {
                            unit: "hour",
                        },
                        grid: {
                            display: false
                        },
                    }
                },
                elements: {
                    point:{
                        radius: 0
                    }
                },
                plugins:{   
                    legend: {
                        display: false
                    },
                },
            }
        });
        brokerfirsttime = false

    } else {
        var chart = brokermyChart
        $.each( Data, function( key, value ) {
            var obj1 = value.x
            var obj2 = value.y

            test = {
                x: new Date(obj1),
                y: obj2
            }
             
            if (firstDate === null) {firstDate = new Date(obj1)}
            lastDate = new Date(obj1)
            lastDate2 = new Date(obj1)

            broker.addData(chart, test)
        });
        

        setTimeout(() => {
            brokermyChart.options.scales.x.max = lastDate
            brokermyChart.update();
        }, 100);
    }
  
}

broker.addData  = function(chart, data) {
    chart.data.datasets.forEach((dataset) => {
        dataset.data.push(data);
    });
    chart.update();
}

broker.stocks.load = function(html) {
    $(".broker-stocks-container").html("")
    $(".broker-stocks-container").append(html)

    $('.broker-stock-element').sort(function(a, b) {
        if (a.textContent < b.textContent) {
          return -1;
        } else {
          return 1;
        }
      }).appendTo('.broker-stocks-container');
}     

broker.user.load = function(html, bought_, sold_) {
    $(".broker-user-items").html("")
    $(".broker-user-items").append(html)

    let bought = Math.round(bought_ * 100) / 100
    let sold = Math.round(sold_ * 100) / 100

    $("#business-user-bought").html(bought + currency)
    $("#business-user-sold").html(sold + currency)
    
    var performance = sold -bought
    performance = Math.round(performance * 100) / 100

    if (performance > 0) {
        $("#business-user-performance").addClass("greencolor")
        $("#business-user-performance").removeClass("redcolor")
    } else {
        $("#business-user-performance").removeClass("greencolor")
        $("#business-user-performance").addClass("redcolor")
    }
    $("#business-user-performance").html(performance + currency)
    
}     


$(document).on('click', '.broker-investment-element', function() {

    if (broker.tabopen == "#broker-home") {
        var name = $(this).data("name")
        var label = $(this).data("label")
        var price = $(this).data("price")
        var change = $(this).data("change")
        var changep = $(this).data("changep")
        var change2 = $(this).data("change2")
        var bought = $(this).data("bought")
        var amount = $(this).data("amount")
        var worth = $(this).data("worth")

        broker.mystock.openprice = price
        broker.mystock.open(name, label, price, change, changep, change2, bought, amount, worth)
    }

    if (broker.tabopen == "#broker-stocks") {
        var name = $(this).data("name")
        var label = $(this).data("label")
        var price = $(this).data("price")
        var change = $(this).data("change")
        var changep = $(this).data("changep")
        var change2 = $(this).data("change2")

        sendData("broker:loadstockgraph", {
            name: name
        })

        broker.stock.openprice = price
        broker.stock.open(name, label, price, change, changep, change2)
    }

    if (broker.tabopen == "#broker-exchange"){
        var name = $(this).data("name")

        broker.exchange.name = name
        BottomSlideUp('#broker-exchange-inputarea-amount', 500, 5);
    } 
})

broker.mystock.open = function(name, label, price, change, changep, change2, bought, amount, worth) {
    broker.footer.open("#broker-mystock")
    $("#broker-mystock-headline").html(label)
    $("#broker-mystock-price").html(price + "€")

    var arrowicon = '<i class="fa-solid fa-arrow-up"></i>'
    $("#broker-mystock-change").addClass("greencolor")
    $("#broker-mystock-change").removeClass("redcolor")
    if (change2 == 0) {
        arrowicon = '<i class="fa-solid fa-arrow-down"></i>'
        $("#broker-mystock-change").removeClass("greencolor")
        $("#broker-mystock-change").addClass("redcolor")
    }

    $("#broker-mystock-buyin").html(bought + currency)

    $("#broker-mystock-change").html(arrowicon + " " + change + "€ (" + changep + "%)")


    $("#broker-mystock-input-amount").val("")

    $("#broker-mystock-amount").html(amount)
    $("#broker-mystock-worth").html(worth + currency)


    broker.stock.openname = name
    broker.mystock.setperformance(price, bought)
}

broker.mystock.setperformance = function(price, bought) {
    var html = ""
    var performancem = Math.round(price - bought)
    var performancep = Math.round((price / bought ) * 100 - 100, 2)
    console.log(price)
    console.log(bought)
    console.log(performancem)
    console.log(performancep)
    var arrowicon = '<i class="fa-solid fa-arrow-up"></i>'
    $("#broker-mystock-performance").addClass("greencolor")
    $("#broker-mystock-performance").removeClass("redcolor")

    if (performancem < 0) {
        arrowicon = '<i class="fa-solid fa-arrow-down"></i>'
        $("#broker-mystock-performance").removeClass("greencolor")
        $("#broker-mystock-performance").addClass("redcolor")
    }

    $("#broker-mystock-performance").html(arrowicon + " " + Math.abs(performancem) + "€ (" + Math.abs(performancep) + "%)")
}

$(document).on('click', '#broker-mystock-buy', function() {
    var name = broker.stock.openname
    var amount = $("#broker-mystock-input-amount").val()

    sendData("broker:buystock", {
        name: name,
        amount: amount
    })
});

$(document).on('click', '#broker-mystock-sell', function() {
    var name = broker.stock.openname
    var amount = $("#broker-mystock-input-amount").val()

    sendData("broker:sellstock", {
        name: name,
        amount: amount
    })
});

const brokermystockamount = document.getElementById('broker-mystock-input-amount');
const brokermystockresult = document.getElementById('broker-mystock-purchaseprice');

const brokermystockinputHandler = function(e) {
    brokermystockresult.innerHTML = (Math.round(e.target.value * broker.mystock.openprice * 100) / 100) + "€";
  }
  
  brokermystockamount.addEventListener('input', brokermystockinputHandler);
  brokermystockamount.addEventListener('propertychange', brokermystockinputHandler); // for IE8


  const brokerstockamount = document.getElementById('broker-stock-input-amount');
  const brokerstockresult = document.getElementById('broker-stock-purchaseprice');
  
  const brokerstockinputHandler = function(e) {
      var price = (Math.round(parseFloat(e.target.value) * parseFloat(broker.stock.openprice) * 100) / 100)

      brokerstockresult.innerHTML = price + "€";
    }
    
    brokerstockamount.addEventListener('input', brokerstockinputHandler);
    brokerstockamount.addEventListener('propertychange', brokerstockinputHandler); // for IE8
  

broker.stock.open = function(name, label, price, change, changep, change2) {
    broker.footer.open("#broker-stock")
    $("#broker-stock-headline").html(label)
    $("#broker-stock-price").html(price + "€")

    var arrowicon = '<i class="fa-solid fa-arrow-up"></i>'
    $("#broker-stock-change").addClass("greencolor")
    $("#broker-stock-change").removeClass("redcolor")
    if (change2 == 0) {
        arrowicon = '<i class="fa-solid fa-arrow-down"></i>'
        $("#broker-stock-change").removeClass("greencolor")
        $("#broker-stock-change").addClass("redcolor")
    }
    broker.stock.openname = name
    $("#broker-stock-change").html(arrowicon + " " + change + "€ (" + changep + "%)")

    $("#broker-stock-input-amount").val("")
}

var brockstockchartctx = document.getElementById('brokerStockchart').getContext('2d');
var  brockstockchart = new Chart(brockstockchartctx, {});

broker.stock.loadChart = function(Data) {
    var newData = []
    console.log("load")
    brockstockchart.destroy()

    $.each( Data, function( key, value ) {
        var obj1 = value.x
        var obj2 = value.y

        newData.push({
            x: new Date(obj1),
            y: obj2
        })
        if (firstDate === null) {firstDate = new Date(obj1)}
        lastDate = new Date(obj1)
        lastDate2 = new Date(obj1)
    });
    console.log("load 2")
    setTimeout(function() {
        brockstockchart = new Chart(brockstockchartctx, {
            type: 'line',
            data: {
                // labels: TimeData,
                datasets: [{
                    label: "Bitcoin in $",
                    data: newData,
                    backgroundColor: [
    
                        'rgba(0, 255, 0, 0.1)'
                    ],
                    borderColor: [
                        'rgba(0, 255, 0, 1)'
                    ],
                    borderWidth: 1.5,
                    fill: true, 
                    tension: 0.2,
                    pointHoverRadius: 10,
                },
            ]
            },
            options: {
                bezierCurve : true,
                responsive: false,
                maintainAspectRatio: true,
                scales: {
                    y: {
                        display: false,
                        beginAtZero: false
                    },
                    x: {
                        // display: true,
                        min: firstDate,
                        max: lastDate,
                        type: "time",
                        time: {
                            unit: "hour",
                        },
                        grid: {
                            display: false
                        },
                    }
                },
                elements: {
                    point:{
                        radius: 0
                    }
                },
                plugins:{   
                    legend: {
                        display: false
                    },
                },
            }
        });
    }, 0)
   
}

//  
$(document).on('click', '#broker-stock-buy', function() {
    var name = broker.stock.openname
    var amount = $("#broker-stock-input-amount").val()

    sendData("broker:buystock", {
        name: name,
        amount: amount
    })
});

$(document).on('click', '#broker-exchange-inputarea-amount-cancel', function() {
    BottomSlideDown('#broker-exchange-inputarea-amount', 500, -70);
    $("#broker-exchange-inputarea-amountinput").val("")
    $("#broker-exchange-inputarea-id-input").val("")
});

$(document).on('click', '#broker-exchange-inputarea-amount-submit', function() {
    var amount = $("#broker-exchange-inputarea-amountinput").val()

    if (amount == "" || amount == null) return


    BottomSlideDown('#broker-exchange-inputarea-amount', 500, -70);

    BottomSlideUp('#broker-exchange-inputarea-id', 500, 5);


    broker.exchange.amount = amount

});


$(document).on('click', '#broker-exchange-inputarea-id-cancel', function() {
    BottomSlideDown('#broker-exchange-inputarea-id', 500, -70);
    broker.exchange.amount = null
    $("#broker-exchange-inputarea-amountinput").val("")
});

$(document).on('click', '#broker-exchange-inputarea-id-back', function() {
    BottomSlideDown('#broker-exchange-inputarea-id', 500, -70);
    BottomSlideUp('#broker-exchange-inputarea-amount', 500, 5);
});

$(document).on('click', '#broker-exchange-inputarea-id-submit', function() {
    var id = $("#broker-exchange-inputarea-id-input").val()
    var amount = broker.exchange.amount
    var name = broker.exchange.name
    if (id == "" || id == null) return

    sendData("broker:exchange", {
        name: name,
        amount: amount,
        id: id
    })

    BottomSlideDown('#broker-exchange-inputarea-id', 500, -70);

    $("#broker-exchange-inputarea-amountinput").val("")
    $("#broker-exchange-inputarea-id-input").val("")


});

// Search bars
var brokerstockssearchbar = document.forms['broker-stocks-searchbar'].querySelector('input');
brokerstockssearchbar.addEventListener('keyup', function(e) {
const term = e.target.value.toLocaleLowerCase();
var notAvailable = document.getElementById('notAvailable');
//   $("#titleMain").toggle($('input').val().length == 0);
var hasResults = false;
    console.log("TEst")
$(".broker-investment-element").each(function() {
        if ($(this).data("name").toString().toLowerCase().includes(term.toString())) {
            $(this).show(0);
        } else {
            $(this).hide(0);
        }
    })
});

var brokerexchangesearchbar = document.forms['broker-exchange-searchbar'].querySelector('input');
brokerexchangesearchbar.addEventListener('keyup', function(e) {
const term = e.target.value.toLocaleLowerCase();
var notAvailable = document.getElementById('notAvailable');
//   $("#titleMain").toggle($('input').val().length == 0);
var hasResults = false;
    console.log("TEst")
    $(".broker-investment-element").each(function() {
        if ($(this).data("name").toString().toLowerCase().includes(term.toString())) {
            $(this).show(0);
        } else {
            $(this).hide(0);
        }
    })
});

// Footer
   
$(document).on('click', '#footer-broker-home', function() {
    broker.footer.open("#broker-home")

    broker.footer.icon(this)
});

$(document).on('click', '#footer-broker-stocks', function() {
    broker.footer.open("#broker-stocks")

    broker.footer.icon(this)
});

$(document).on('click', '#footer-broker-exchange', function() {
    broker.footer.open("#broker-exchange")

    broker.footer.icon(this)
});

$(document).on('click', '#footer-broker-user', function() {
    broker.footer.open("#broker-user")

    broker.footer.icon(this)
})

broker.footer.open = function(newopen) {
    if (newopen == broker.tabopen) return
 
    $("#broker-exchange-searchbar-input").val("")
    $("#broker-stocks-searchbar-input").val("")



    setTimeout(function(){
        $(broker.tabopen).animate({
            "margin-left": "100%"
        })
        $(newopen).css({
            "margin-left": "0%",
            "margin-right": "100%"
        })
        setTimeout(function(){
            $(newopen).animate({
                "margin-right": "0%"
            }, 500)
            $(".broker-investment-element").each(function() {
                $(this).show(100);
            })
        }, 10)
        broker.lasttabopen = broker.tabopen 
        broker.tabopen = newopen
    }, 10)
}

broker.footer.icon = function(obj) {
    $("#footer-broker-home").removeClass("purplecolor")
    $("#footer-broker-stocks").removeClass("purplecolor")
    $("#footer-broker-exchange").removeClass("purplecolor")
    $("#footer-broker-user").removeClass("purplecolor")

    $(obj).addClass("purplecolor")
}
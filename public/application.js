$(function() {
    fetch_from_timelines_quebec(0);
});


var applicants = [];
var fetch_from_timelines_quebec = function(count) {
    var url = "http://timelines-quebec.com/timelines/federal/${c}/carregar".replace("${c}", count);

    $.getJSON(url, function (data) {
        if (data.processos.length == 0) 
            printChart( parseMonths(applicants) );

        applicants.concat(data.processos)

        fetch_from_timelines_quebec(count);
    })
}

var parseMonths = function(apps) {
    console.log(apps)
};

var printChart = function (months_array) {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'column'
            },
            title: {
                text: 'Monthly Average Rainfall'
            },
            subtitle: {
                text: 'Source: WorldClimate.com'
            },
            xAxis: {
                categories: [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Rainfall (mm)'
                }
            },
            legend: {
                layout: 'vertical',
                backgroundColor: '#FFFFFF',
                align: 'left',
                verticalAlign: 'top',
                x: 100,
                y: 70,
                floating: true,
                shadow: true
            },
            tooltip: {
                formatter: function() {
                    return ''+
                        this.x +': '+ this.y +' mm';
                }
            },
            plotOptions: {
                column: {
                    pointPadding: 0.0,
                    borderWidth: 0
                }
            },
                series: [{
                name: 'Documentos enviados',
                data: months_array
    
            }]
        });
    });
}
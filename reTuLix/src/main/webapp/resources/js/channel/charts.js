google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['년도', '조회수', '좋아요수', '구독수'],
    ['2017',  1000,      400,     500],
    ['2018',  1170,      460,     600],
    ['2019',  660,       1120,    700],
    ['2020',  1030,      540,     800]
  ]);

  var options = {
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

  chart.draw(data, options);
}
{include file="sections/header.tpl"}


<div class="row">

    <div class="card col-lg-3 col-xs-6">
        <div class="card-body small-box card-info row">
            <div class="col-lg-9 inner">
                <h4 style="color:black;"><sup>{$_c['currency_code']}</sup>
                    {number_format($iday,0,$_c['dec_point'],$_c['thousands_sep'])}</h4>
                <p>{Lang::T('Income Today')}</p>
            </div>
            <div class="col-lg-3 icon">
                <i class="las la-money-bill" style="font-size: 50px;"></i>
            </div>
            <a style="color:rgb(1, 1, 75);" href="{$_url}reports/by-date"
                class="col-lg-12 small-box-footer">{Lang::T('View Reports')} <i
                    class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>

    <div class="card col-lg-3 col-xs-6">
        <div class="card-body small-box card-success row">
            <div class="col-lg-8 inner">
                <h4 style="color:black;"><sup>{$_c['currency_code']}</sup>
                    {number_format($imonth,0,$_c['dec_point'],$_c['thousands_sep'])}</h4>

                <p>{Lang::T('Income This Month')}</p>
            </div>
            <div class="col-lg-3 icon">
                <i class="ion ion-stats-bars" style="font-size: 50px;"></i>
            </div>
            <a style="color:rgb(1, 1, 75);" href="{$_url}reports/by-period"
                class="col-lg-12 small-box-footer">{Lang::T('View Reports')} <i
                    class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    <div class="card col-lg-3 col-xs-6">
        <div class="card-body small-box card-warning row">
            <div class="col-lg-9 inner">
                <h4 style="color:black;">{$u_act}/{$u_all}</h4>

                <p>{Lang::T('Users Active')}</p>
            </div>
            <div class="col-lg-3 icon">
                <i class="ion ion-person" style="font-size: 50px;"></i>
            </div>
            <a href="{$_url}prepaid/list" class="col-lg-12 small-box-footer">{Lang::T('View All')} <i
                    class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
    <div class="card col-lg-3 col-xs-6">
        <div class="card-body small-box  card-primary row">
            <div class="col-lg-9 inner">
                <h4 style="color:black;">{$c_all}</h4>

                <p>{Lang::T('Total Users')}</p>
            </div>
            <div class="col-lg-3 icon">
                <i class="fa fa-users" style="font-size: 50px;"></i>
            </div>
            <a style="color:rgb(1, 1, 75);" href="{$_url}customers/list"
                class="col-lg-12 small-box-footer">{Lang::T('View All')} <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
</div>
<div class="row">
    <!-- solid sales graph -->
    {if $_c['hide_mrc'] != 'yes'}
        <div class="card col-md-6 card-solid ">
            <div class="card-header">
                <i class="fa fa-th"></i>

                <h3 class="card-title">{Lang::T('Monthly Registered Customers')}</h3>

                <div class="card-tools pull-right">
                    <button type="button" class="btn bg-teal btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                    <a href="{$_url}settings/app#hide_dashboard_content" class="btn bg-teal btn-sm"><i
                            class="fa fa-times"></i>
                    </a>
                </div>
            </div>
            <div class="card-body border-radius-none">
                <canvas class="chart" id="chart" style="height: 250px;"></canvas>
            </div>
        </div>
    {/if}


    <!-- solid sales graph -->
    {if $_c['hide_tms'] != 'yes'}
        <div class="card col-md-6 card-solid ">
            <div class="card-header">
                <i class="fa fa-incard"></i>

                <h3 class="card-title">{Lang::T('Total Monthly Sales')}</h3>

                <div class="card-tools pull-right">
                    <button type="button" class="btn bg-teal btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
                    </button>
                    <a href="{$_url}settings/app#hide_dashboard_content" class="btn bg-teal btn-sm"><i
                            class="fa fa-times"></i>
                    </a>
                </div>
            </div>
            <div class="card-body border-radius-none">
                <canvas class="chart" id="salesChart" style="height: 250px;"></canvas>
            </div>
        </div>
    {/if}



    <div class="col-md-6">
        {if $_c['disable_voucher'] != 'yes' && $stocks['unused']>0 || $stocks['used']>0}
            {if $_c['hide_vs'] != 'yes'}
                <div class="card  mb20 card-hovered project-stats table-responsive">
                    <div class="card-header">Vouchers Stock</div>
                    <div class="table-responsive">
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th>{Lang::T('Plan Name')}</th>
                                    <th>unused</th>
                                    <th>used</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $plans as $stok}
                                    <tr>
                                        <td>{$stok['name_plan']}</td>
                                        <td>{$stok['unused']}</td>
                                        <td>{$stok['used']}</td>
                                    </tr>
                                </tbody>
                            {/foreach}
                            <tr>
                                <td>Total</td>
                                <td>{$stocks['unused']}</td>
                                <td>{$stocks['used']}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            {/if}
        {/if}
        {if $_c['hide_uet'] != 'yes'}
            <div class="card card-warning mb20 card-hovered project-stats table-responsive">
                <div class="card-header">{Lang::T('User Expired, Today')}</div>
                <div class="table-responsive">
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <th>{Lang::T('Username')}</th>
                                <th>{Lang::T('Created On')}</th>
                                <th>{Lang::T('Expires On')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $expire as $expired}
                                <tr>
                                    <td><a href="{$_url}customers/viewu/{$expired['username']}">{$expired['username']}</a></td>
                                    <td>{Lang::dateAndTimeFormat($expired['recharged_on'],$expired['recharged_time'])}
                                    </td>
                                    <td>{Lang::dateAndTimeFormat($expired['expiration'],$expired['time'])}
                                    </td>
                                </tr>
                            </tbody>
                        {/foreach}
                    </table>
                </div>
                &nbsp; {$paginator['contents']}
            </div>
        {/if}
    </div>


    <div class="col-md-5">
        {if $_c['hide_pg'] != 'yes'}
            <div class="card card-success card-hovered mb20 activities">
                <div class="card-header">{Lang::T('Payment Gateway')}: {$_c['payment_gateway']}</div>
            </div>
        {/if}
        {if $_c['hide_aui'] != 'yes'}
            <div class="card card-info card-hovered mb20 activities">
                <div class="card-header">{Lang::T('All Users Insights')}</div>
                <div class="card-body">
                    <canvas id="userRechargesChart"></canvas>
                </div>
            </div>
        {/if}
        {if $_c['hide_al'] != 'yes'}
            <div class="card card-info card-hovered mb20 activities">
                <div class="card-header"><a href="{$_url}logs">{Lang::T('Activity Log')}</a></div>
                <div class="card-body">
                    <ul class="list-unstyled">
                        {foreach $dlog as $dlogs}
                            <li class="primary">
                                <span class="point"></span>
                                <span class="time small text-muted">{Lang::timeElapsed($dlogs['date'],true)}</span>
                                <p>{$dlogs['description']}</p>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        {/if}
    </div>


</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>

<script type="text/javascript">
    {if $_c['hide_mrc'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                var counts = JSON.parse('{/literal}{$monthlyRegistered|json_encode}{literal}');

                var monthNames = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];

                var labels = [];
                var data = [];

                for (var i = 1; i <= 12; i++) {
                    var month = counts.find(count => count.date === i);
                    labels.push(month ? monthNames[i - 1] : monthNames[i - 1].substring(0, 3));
                    data.push(month ? month.count : 0);
                }

                var ctx = document.getElementById('chart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Registered Members',
                            data: data,
                            backgroundColor: 'rgba(0, 0, 255, 0.5)',
                            borderColor: 'rgba(0, 0, 255, 0.7)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                grid: {
                                    display: false
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.1)'
                                }
                            }
                        }
                    }
                });
            });
        {/literal}
    {/if}
    {if $_c['hide_tmc'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                var monthlySales = JSON.parse('{/literal}{$monthlySales|json_encode}{literal}');

                var monthNames = [
                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];

                var labels = [];
                var data = [];

                for (var i = 1; i <= 12; i++) {
                    var month = findMonthData(monthlySales, i);
                    labels.push(month ? monthNames[i - 1] : monthNames[i - 1].substring(0, 3));
                    data.push(month ? month.totalSales : 0);
                }

                var ctx = document.getElementById('salesChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Monthly Sales',
                            data: data,
                            backgroundColor: 'rgba(2, 10, 242)', // Customize the background color
                            borderColor: 'rgba(255, 99, 132, 1)', // Customize the border color
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                grid: {
                                    display: false
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.1)'
                                }
                            }
                        }
                    }
                });
            });

            function findMonthData(monthlySales, month) {
                for (var i = 0; i < monthlySales.length; i++) {
                    if (monthlySales[i].month === month) {
                        return monthlySales[i];
                    }
                }
                return null;
            }
        {/literal}
    {/if}
    {if $_c['hide_aui'] != 'yes'}
        {literal}
            document.addEventListener("DOMContentLoaded", function() {
                // Get the data from PHP and assign it to JavaScript variables
                var u_act = '{/literal}{$u_act}{literal}';
                var c_all = '{/literal}{$c_all}{literal}';
                var u_all = '{/literal}{$u_all}{literal}';
                //lets calculate the inactive users as reported
                var expired = u_all - u_act;
                var inactive = c_all - u_all;
                // Create the chart data
                var data = {
                    labels: ['Active Users', 'Expired Users', 'Inactive Users'],
                    datasets: [{
                        label: 'User Recharges',
                        data: [parseInt(u_act), parseInt(expired), parseInt(inactive)],
                        backgroundColor: ['rgba(4, 191, 13)', 'rgba(191, 35, 4)', 'rgba(0, 0, 255, 0.5'],
                        borderColor: ['rgba(0, 255, 0, 1)', 'rgba(255, 99, 132, 1)', 'rgba(0, 0, 255, 0.7'],
                        borderWidth: 1
                    }]
                };

                // Create chart options
                var options = {
                    responsive: true,
                    aspectRatio: 1,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                boxWidth: 15
                            }
                        }
                    }
                };

                // Get the canvas element and create the chart
                var ctx = document.getElementById('userRechargesChart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'pie',
                    data: data,
                    options: options
                });
            });
        {/literal}
    {/if}
</script>
<script>
    window.addEventListener('DOMContentLoaded', function() {
        $.getJSON("./version.json?" + Math.random(), function(data) {
            var localVersion = data.version;
            $('#version').html('Version: ' + localVersion);
            $.getJSON(
                "https://raw.githubusercontent.com/hotspotbilling/phpnuxbill/master/version.json?" +
                Math
                .random(),
                function(data) {
                    var latestVersion = data.version;
                    if (localVersion !== latestVersion) {
                        $('#version').html('Latest Version: ' + latestVersion);
                    }
                });
        });

    });
</script>

{include file="sections/footer.tpl"}
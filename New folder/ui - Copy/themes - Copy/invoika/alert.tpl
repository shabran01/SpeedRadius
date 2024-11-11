<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{ucwords(Lang::T($type))} - {$_c['CompanyName']}</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="shortcut icon" href="ui/ui/images/logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="ui/ui/styles/bootstrap.min.css">
    <link rel="stylesheet" href="ui/ui/styles/modern-AdminLTE.min.css">
    <meta http-equiv="refresh" content="3; url={$url}">
</head>

<body class="hold-transition lockscreen">
    <div class="lockscreen-wrapper">
        <div class="card card-{$type}">
            <div class="card-header">{ucwords(Lang::T($type))}</div>
            <div class="card-body">
                {$text}
            </div>
            <div class="card-footer">
                <a href="{$url}" id="button" class="btn btn-{$type} btn-block btn-block">{Lang::T('Click Here')} (3)</a>
            </div>
        </div>
        <div class="lockscreen-footer text-center">
            {$_c['CompanyName']}
        </div>
    </div>

    <script>
        var time = 3;
        timer();

        function timer() {
            setTimeout(() => {
                time--;
                if (time > -1) {
                    document.getElementById("button").innerHTML = "{Lang::T('Click Here')} (" + time + ")";
                    timer();
                }
            }, 1000);
        }
    </script>
</body>

</html>
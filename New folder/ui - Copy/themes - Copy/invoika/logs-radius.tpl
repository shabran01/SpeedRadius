{include file="sections/header.tpl"}
<!-- pool -->
<div class="row">
    <div class="col-sm-12">
        <div class="card card-hovered mb20 ">
            <div class="card-header">
                Radius
            </div>
            <div class="card-body">
                <div class="text-center" style="padding: 15px">
                    <div class="col-md-4">
                        <form id="site-search" method="post" action="{$_url}logs/radius/">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <span class="fa fa-search"></span>
                                </div>
                                <input type="text" name="q" class="form-control" value="{$q}"
                                    placeholder="{Lang::T('Search by Name')}...">
                                <div class="input-group-btn">
                                    <button class="btn btn-success" type="submit">{Lang::T('Search')}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-8">
                        <form class="form-inline" method="post" action="{$_url}logs/radius/">
                            <div class="input-group has-error">
                                <span class="input-group-addon">Keep Logs </span>
                                <input type="text" name="keep" class="form-control" placeholder="90" value="90">
                                <span class="input-group-addon">Days</span>
                            </div>
                            <button type="submit" class="btn btn-danger btn-sm"
                                onclick="return confirm('Clear old logs?')">Clean Logs</button>
                        </form>
                    </div>&nbsp;
                </div>
                <br>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle table-nowrap mb-0">
                        <tbody>
                            {foreach $d as $ds}
                                <tr>
                                    <td width="30px">{$ds['id']}</td>
                                    <td width="200px">{Lang::dateTimeFormat($ds['authdate'])}</td>
                                    <td width="100px">{$ds['username']}</td>
                                    <td width="10px"><input type="password" value="{$ds['pass']}"
                                            style="width:300px;border: 0px; text-align: right;" class="pull-right"
                                            onmouseleave="this.type = 'password'" onmouseenter="this.type = 'text'"
                                            onclick="this.select()"></td>
                                    <td>{$ds['reply']}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                {$paginator['contents']}
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}
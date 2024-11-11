{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12">
        <div class="card card-hovered mb20 ">
            <div class="card-header">
                {if in_array($_admin['user_type'],['SuperAdmin','Admin'])}
                    <div class="btn-group pull-right">
                        <a class="btn btn-primary btn-xs" title="save" href="{$_url}customers/csv"
                            onclick="return confirm('This will export to CSV?')"><span class="glyphicon glyphicon-download"
                                aria-hidden="true"></span> CSV</a>
                    </div>
                {/if}
                {Lang::T('Manage Contact')}
            </div>
            <div class="card-body">
                <div class="md-whiteframe-z1 mb20 text-center" style="padding: 15px">
                    <div class="col-md-8">
                        <form id="site-search" method="post" action="{$_url}customers/list/">
                            <div class="input-group">
                                <input type="text" name="search" value="{$search}" class="form-control"
                                    placeholder="{Lang::T('Search')}...">
                                <div class="input-group-btn">
                                    <button class="btn btn-success" type="submit"><span
                                            class="fa fa-search"></span></button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <a href="{$_url}customers/add" class="btn btn-primary btn-block"><i class="ion ion-android-add">
                            </i> {Lang::T('Add New Contact')}</a>
                    </div>&nbsp;
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle table-nowrap mb-0">
                            <thead>
                                <tr>
                                    <th>{Lang::T('Username')}</th>
                                    <th>{Lang::T('Full Name')}</th>
                                    <th>{Lang::T('Balance')}</th>
                                    <th>{Lang::T('Phone Number')}</th>
                                    <th>{Lang::T('Email')}</th>
                                    <th>{Lang::T('Package')}</th>
                                    <th>{Lang::T('Service Type')}</th>
                                    <th>{Lang::T('Created On')}</th>
                                    <th>{Lang::T('Manage')}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $d as $ds}
                                    <tr>
                                        <td onclick="window.location.href = '{$_url}customers/view/{$ds['id']}'"
                                            style="cursor:pointer;">{$ds['username']}</td>
                                        <td onclick="window.location.href = '{$_url}customers/view/{$ds['id']}'"
                                            style="cursor: pointer;">{$ds['fullname']}</td>
                                        <td>{Lang::moneyFormat($ds['balance'])}</td>
                                        <td>{$ds['phonenumber']}</td>
                                        <td>{$ds['email']}</td>
                                        <td align="center" api-get-text="{$_url}autoload/customer_is_active/{$ds['id']}">
                                            <span class="label label-default">&bull;</span>
                                        </td>
                                        <td>{$ds['service_type']}</td>
                                        <td>{Lang::dateTimeFormat($ds['created_at'])}</td>
                                        <td align="center">
                                            <a href="{$_url}customers/view/{$ds['id']}" id="{$ds['id']}"
                                                style="margin: 0px;"
                                                class="btn btn-success btn-xs">&nbsp;&nbsp;{Lang::T('View')}&nbsp;&nbsp;</a>
                                            <a href="{$_url}prepaid/recharge/{$ds['id']}" id="{$ds['id']}"
                                                style="margin: 0px;"
                                                class="btn btn-primary btn-xs">{Lang::T('Recharge')}</a>
                                        </td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
                {$paginator['contents']}
            </div>
        </div>
    </div>
</div>

{include file="sections/footer.tpl"}
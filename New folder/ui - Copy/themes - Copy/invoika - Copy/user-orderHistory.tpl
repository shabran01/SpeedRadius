{include file="sections/user-header.tpl"}
<!-- user-orderHistory -->

<div class="row">
    <div class="col-sm-12">
        <div class="card mb20 card-hovered ">
            <div class="card-header">{Lang::T('Order History')}</div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="datatable" class="table table-bordered align-middle table-nowrap mb-0">
                        <thead>
                            <tr>
                                <th>{Lang::T('Plan Name')}</th>
                                <th>{Lang::T('Gateway')}</th>
                                <th>{Lang::T('Routers')}</th>
                                <th>{Lang::T('Type')}</th>
                                <th>{Lang::T('Plan Price')}</th>
                                <th>{Lang::T('Created On')}</th>
                                <th>{Lang::T('Expires On')}</th>
                                <th>{Lang::T('Date Done')}</th>
                                <th>{Lang::T('Method')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $d as $ds}
                                <tr>
                                    <td><a href="{$_url}order/view/{$ds['id']}">{$ds['plan_name']}</a></td>
                                    <td>{$ds['gateway']}</td>
                                    <td>{$ds['routers']}</td>
                                    <td>{$ds['payment_channel']}</td>
                                    <td>{Lang::moneyFormat($ds['price'])}</td>
                                    <td class="text-primary">{date("{$_c['date_format']} H:i",
                                        strtotime($ds['created_date']))}</td>
                                    <td class="text-danger">{date("{$_c['date_format']} H:i",
                                        strtotime($ds['expired_date']))}</td>
                                    <td class="text-success">{if $ds['status']!=1}{date("{$_c['date_format']} H:i",
                                        strtotime($ds['paid_date']))}{/if}</td>
                                    <td>{if $ds['status']==1}{Lang::T('UNPAID')}
                                        {elseif $ds['status']==2}{Lang::T('PAID')}
                                        {elseif $ds['status']==3}{$_L['FAILED']}
                                        {elseif $ds['status']==4}{Lang::T('CANCELED')}
                                        {elseif $ds['status']==5}{Lang::T('UNKNOWN')}
                                        {/if}</td>
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


{include file="sections/user-footer.tpl"}
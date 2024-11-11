{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12 col-md-12">
        <div class="card  card-hovered card-stacked mb30">
            <div class="card-header">{Lang::T('Add Service Plan')}</div>
            <div class="card-body">
                <form class="form-horizontal" method="post" role="form" action="{$_url}services/add-post">
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Status')}</label>
                        <div class="col-md-10">
                            <input type="radio" name="enabled" value="1" checked> Enable
                            <input type="radio" name="enabled" value="0"> Disable
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Client Can Purchase')}</label>
                        <div class="col-md-10">
                            <input type="radio" name="allow_purchase" value="yes" checked> Yes
                            <input type="radio" name="allow_purchase" value="no"> No
                        </div>
                    </div>
                    {if $_c['radius_enable']}
                        <div class="form-group">
                            <label class="col-md-2 control-label">Radius</label>
                            <div class="col-md-6">
                                <label class="radio-inline">
                                    <input type="checkbox" name="radius" onclick="isRadius(this)" value="1"> Radius Plan
                                </label>
                            </div>
                            <p class="help-block col-md-4">{Lang::T('Cannot be change after saved')}</p>
                        </div>
                    {/if}
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Plan Name')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="name" name="name" maxlength="40">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Plan Type')}</label>
                        <div class="col-md-10">
                            <input type="radio" id="Unlimited" name="typebp" value="Unlimited" checked>
                            {Lang::T('Unlimited')}
                            <input type="radio" id="Limited" name="typebp" value="Limited"> {Lang::T('Limited')}
                        </div>
                    </div>
                    <div style="display:none;" id="Type">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{Lang::T('Limit Type')}</label>
                            <div class="col-md-10">
                                <input type="radio" id="Time_Limit" name="limit_type" value="Time_Limit" checked>
                                {Lang::T('Time Limit')}
                                <input type="radio" id="Data_Limit" name="limit_type" value="Data_Limit">
                                {Lang::T('Data Limit')}
                                <input type="radio" id="Both_Limit" name="limit_type" value="Both_Limit">
                                {Lang::T('Both Limit')}
                            </div>
                        </div>
                    </div>
                    <div style="display:none;" id="TimeLimit">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{Lang::T('Time Limit')}</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="time_limit" name="time_limit" value="0">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="time_unit" name="time_unit">
                                    <option value="Hrs">{Lang::T('Hrs')}</option>
                                    <option value="Mins">{Lang::T('Mins')}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div style="display:none;" id="DataLimit">
                        <div class="form-group">
                            <label class="col-md-2 control-label">{Lang::T('Data Limit')}</label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="data_limit" name="data_limit" value="0">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control" id="data_unit" name="data_unit">
                                    <option value="MB">MBs</option>
                                    <option value="GB">GBs</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label"><a
                                href="{$_url}bandwidth/add">{Lang::T('Bandwidth Name')}</a></label>
                        <div class="col-md-6">
                            <select id="id_bw" name="id_bw" class="form-control select2">
                                <option value="">{Lang::T('Select Bandwidth')}...</option>
                                {foreach $d as $ds}
                                    <option value="{$ds['id']}">{$ds['name_bw']}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Plan Price')}</label>
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">{$_c['currency_code']}</span>
                                <input type="number" class="form-control" name="price" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Shared Users')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="sharedusers" name="sharedusers" value="1">
                            <p class="help-block">{Lang::T('1 user can be used for many devices?')}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">{Lang::T('Plan Validity')}</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="validity" name="validity">
                        </div>
                        <div class="col-md-2">
                            <select class="form-control" id="validity_unit" name="validity_unit">
                                <option value="Mins" {if $d['validity_unit'] eq 'Mins'} selected {/if}>{Lang::T('Mins')}
                                </option>
                                <option value="Hrs" {if $d['validity_unit'] eq 'Hrs'} selected {/if}>{Lang::T('Hrs')}
                                </option>
                                <option value="Days" {if $d['validity_unit'] eq 'Days'} selected {/if}>{Lang::T('Days')}
                                </option>
                                <option value="Months" {if $d['validity_unit'] eq 'Months'} selected {/if}>
                                    {Lang::T('Months')}</option>
                            </select>
                        </div>
                    </div>
                    <span id="routerChoose" class="">
                        <div class="form-group">
                            <label class="col-md-2 control-label"><a
                                    href="{$_url}routers/add">{Lang::T('Router Name')}</a></label>
                            <div class="col-md-6">
                                <select id="routers" name="routers" required class="form-control select2">
                                    <option value=''>{Lang::T('Select Routers')}</option>
                                    {foreach $r as $rs}
                                        <option value="{$rs['name']}">{$rs['name']}</option>
                                    {/foreach}
                                </select>
                                <p class="help-block">{Lang::T('Cannot be change after saved')}</p>
                            </div>
                        </div>
                    </span>
                    <legend>{Lang::T('Expired Action')} <sub>{Lang::T('Optional')}</sub></legend>
                    <div class="form-group" id="ipPool">
                        <label class="col-md-2 control-label"><a
                                href="{$_url}pool/add">{Lang::T('Expired IP Pool')}</a></label>
                        <div class="col-md-6">
                            <select id="pool_expired" name="pool_expired" class="form-control select2">
                                <option value=''>{Lang::T('Select Pool')}</option>
                            </select>
                        </div>
                    </div>
                    {* <div class="form-group" id="AddressList">
                        <label class="col-md-2 control-label">{Lang::T('Address List')}</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="list_expired" id="list_expired">
                        </div>
                    </div> *}
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <button class="btn btn-success"
                                type="submit">{Lang::T('Save Changes')}</button>
                            Or <a href="{$_url}services/hotspot">{Lang::T('Cancel')}</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
{if $_c['radius_enable']}
    {literal}
        <script>
            function isRadius(cek) {
                if (cek.checked) {
                    $("#routerChoose").addClass('hidden');
                    document.getElementById("routers").required = false;
                    $("#pool_expired").html('');
                    $.ajax({
                        url: "index.php?_route=autoload/pool",
                        data: "routers=radius",
                        cache: false,
                        success: function(msg) {
                            $("#pool_expired").html(msg);
                        }
                    });
                } else {
                    document.getElementById("routers").required = true;
                    $("#routerChoose").removeClass('hidden');
                }
            }
        </script>
    {/literal}
{/if}

{include file="sections/footer.tpl"}
{include file="sections/header.tpl"}
<div class="row">
    <div class="col-sm-12">
        <div class="card  card-hovered">
            <div class="card-header">{Lang::T('Plugin')}</div>
            <div class="card-body row">
                {foreach $plugins as $plugin}
                    <div class="col-md-4">
                        <div class="box box-hovered mb20 box-primary">
                            <div class="box-header">
                                <h3 class="box-title text1line">{$plugin['name']}</h3>
                            </div>
                            <div class="box-body" style="overflow-y: scroll;">
                                <div style="max-height: 50px; min-height: 50px;">{$plugin['description']}</div>
                            </div>
                            <div class="box-footer ">
                                <center><small><i>@{$plugin['author']} Last update: {$plugin['last_update']}</i></small></center>
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <a href="{$plugin['url']}" target="_blank" class="btn btn-primary"><i
                                            class="ion ion-chatboxes"></i> Website</a>
                                    <a href="{$plugin['github']}" target="_blank" class="btn btn-success"><i
                                            class="ion ion-chatboxes"></i> Github</a>
                                    <a {if $zipExt } href="{$_url}pluginmanager/install/plugin/{$plugin['id']}"
                                            onclick="return confirm('Installing plugin will take some time to complete, do not close the page while it loading to install the plugin')"
                                        {else} href="#" onclick="alert('PHP ZIP extension is not installed')" 
                                        {/if}
                                        class="btn btn-warning"><i class="ion ion-chatboxes"></i> Install</a>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
        <div class="card  card-hovered">
            <div class="card-header">{Lang::T('Payment Gateway')}</div>
            <div class="card-body row">
                {foreach $pgs as $pg}
                    <div class="col-md-4">
                        <div class="box box-hovered mb20 box-primary">
                            <div class="box-header">
                                <h3 class="box-title text1line">{$pg['name']}</h3>
                            </div>
                            <div class="box-body" style="overflow-y: scroll;">
                                <div style="max-height: 50px; min-height: 50px;">{$pg['description']}</div>
                            </div>
                            <div class="box-footer ">
                                <center><small><i>@{$pg['author']} Last update: {$pg['last_update']}</i></small></center>
                                <div class="btn-group btn-group-justified" role="group" aria-label="...">
                                    <a href="{$pg['url']}" target="_blank" class="btn btn-primary"><i
                                            class="ion ion-chatboxes"></i> Website</a>
                                    <a href="{$pg['github']}" target="_blank" class="btn btn-success"><i
                                            class="ion ion-chatboxes"></i> Github</a>
                                    <a {if $zipExt } href="{$_url}pluginmanager/install/payment/{$pg['id']}"
                                            onclick="return confirm('Installing plugin will take some time to complete, do not close the page while it loading to install the plugin')"
                                        {else} href="#" onclick="alert('PHP ZIP extension is not available')" 
                                        {/if}
                                        class="btn btn-warning"><i class="ion ion-chatboxes"></i> Install</a>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{include file="sections/footer.tpl"}
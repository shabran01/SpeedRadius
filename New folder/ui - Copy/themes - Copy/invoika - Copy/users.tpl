{include file="sections/header.tpl"}
<!-- users -->

<div class="row">
    <div class="col-sm-12">
        <div class="card card-hovered mb20 ">
            <div class="card-header">{Lang::T('Manage Administrator')}</div>
            <div class="card-body">
                <div class="md-whiteframe-z1 mb20 text-center" style="padding: 15px">
                    <div class="col-md-8">
                        <form id="site-search" method="post" action="{$_url}settings/users/">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <span class="fa fa-search"></span>
                                </div>
                                <input type="text" name="search" value="{$search}" class="form-control"
                                    placeholder="Search by Username...">
                                <div class="input-group-btn">
                                    <button class="btn btn-success" type="submit">{Lang::T('Search')}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4">
                        <a href="{$_url}settings/users-add" class="btn btn-primary btn-block"><i
                                class="ion ion-android-add"> </i> {Lang::T('Add New Administrator')}</a>
                    </div>&nbsp;
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered align-middle table-nowrap mb-0">
                        <thead>
                            <tr>
                                <th>{Lang::T('Username')}</th>
                                <th>{Lang::T('Full Name')}</th>
                                <th>{Lang::T('Phone')}</th>
                                <th>{Lang::T('Email')}</th>
                                <th>{Lang::T('Type')}</th>
                                <th>{Lang::T('Location')}</th>
                                <th>{Lang::T('Agent')}</th>
                                <th>{Lang::T('Last Login')}</th>
                                <th>{Lang::T('Manage')}</th>
                                <th>ID</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $d as $ds}
                                <tr {if $ds['status'] != 'Active'}class="danger"{/if}>
                                    <td>{$ds['username']}</td>
                                    <td>{$ds['fullname']}</td>
                                    <td>{$ds['phone']}</td>
                                    <td>{$ds['email']}</td>
                                    <td>{$ds['user_type']}</td>
                                    <td>{$ds['city']}, {$ds['subdistrict']}, {$ds['ward']}</td>
                                <td>{if $ds['root']}
                                    <a href="{$_url}settings/users-view/{$ds['root']}">
                            {$admins[$ds['root']]}</a>{/if}</td>
                        <td>{if $ds['last_login']}{Lang::timeElapsed($ds['last_login'])}{/if}</td>
                                    <td>
                                        <a href="{$_url}settings/users-view/{$ds['id']}"
                                            class="btn btn-success btn-xs">{Lang::T('View')}</a>
                                        <a href="{$_url}settings/users-edit/{$ds['id']}"
                                            class="btn btn-info btn-xs">{Lang::T('Edit')}</a>
                                        {if ($_admin['id']) neq ($ds['id'])}
                                            <a href="{$_url}settings/users-delete/{$ds['id']}" id="{$ds['id']}"
                                                class="btn btn-danger btn-xs" onclick="return confirm('{Lang::T('Delete')}?')"><i class="glyphicon glyphicon-trash"></i></a>
                                        {/if}
                                    </td>
                                    <td>{$ds['id']}</td>
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
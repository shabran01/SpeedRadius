{include file="sections/header.tpl"}

		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="card  card-hovered card-stacked mb30">
					<div class="card-header">{Lang::T('Recharge Account')}</div>
					<div class="card-body">
						<form class="form-horizontal" method="post" role="form" action="{$_url}prepaid/recharge-post" >
							<div class="form-group">
								<label class="col-md-2 control-label">{Lang::T('Select Account')}</label>
								<div class="col-md-6">
									<select id="personSelect" class="form-control select2" name="id_customer" style="width: 100%" data-placeholder="Select a customer...">
									<option></option>
										{foreach $c as $cs}
											{if $id eq $cs['id']}
												<option value="{$cs['id']}" selected>{$cs['username']}</option>
											{else}
												<option value="{$cs['id']}">{$cs['username']}</option>
											{/if}
										{/foreach}
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">{Lang::T('Type')}</label>
								<div class="col-md-6">
									<label><input type="radio" id="Hot" name="type" value="Hotspot"> {Lang::T('Hotspot Plans')}</label>
									<label><input type="radio" id="POE" name="type" value="PPPOE"> {Lang::T('PPPOE Plans')}</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">{Lang::T('Routers')}</label>
								<div class="col-md-6">
									<select id="server" name="server" class="form-control select2">
										<option value=''>Select Routers</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">{Lang::T('Service Plan')}</label>
								<div class="col-md-6">
									<select id="plan" name="plan" class="form-control select2">
										<option value=''>Select Plans</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10">
									<button class="btn btn-success" type="submit">{Lang::T('Recharge')}</button>
									Or <a href="{$_url}customers/list">{Lang::T('Cancel')}</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>


{include file="sections/footer.tpl"}

<#include "header.ftl">
	
	<#include "menu.ftl">

	<div class="container-fluid">
		<div class="row row-offcanvas row-offcanvas-right">
			 <div class="col-xs-12 col-sm-9 col-sm-push-3">
				${content.body}
			</div>
			<div class="col-xs-6 col-sm-3 col-sm-pull-9 sidebar-offcanvas" id="sidebar"">
				<#include "side_menu.ftl">	
			</div>
		</div>
	</div>
	
<#include "footer.ftl">
	<!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top" >
      <div class="container">
        <div class="navbar-header">
		  <button type="button" data-target="#navbar" data-toggle="collapse" class="navbar-toggle"> 
			  <span class="sr-only">Toggle navigation</span> 
			  <span class="icon-bar"></span> 
			  <span class="icon-bar"></span> 
		  </button>
          <a class="navbar-brand" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>index.html">Lense</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Get Started<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li class="disabled"><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>learn.html">Learn Lense</a></li>
					<li class="disabled"><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>try.html">Try Lense</a></li>
					<li><a href="https://github.com/sergiotaborda/lense-lang">Download</a></li>
				</ul>
			</li>
            <li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Fundamentals<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>tour/tour.html">Language Tour</a></li>
					<li class="disabled"><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>guide.html">Programmer's Guide</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>platforms.html">Target Platforms's Guide</a></li>
						<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>glossary.html">Glossary</a></li>
				</ul>
            </li>
			
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Details<b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>nullability.html">Nullability</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>numbers.html">Numbers</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>strings.html">Strings</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>arrays.html">Arrays</a></li>
					
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>containerLiterals.html">Container Literals</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>objects.html">Classes and Objects</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>constructors.html">Constructors</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>properties.html">Properties</a></li>
				
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>operators.html">Operators</a></li>	
				
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>monads.html">Monads</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>concurrency.html">Concurrency</a></li>
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>erasure.html">Type Erasure</a></li>
					
					<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>enhancements.html">External Enhancements</a></li>
					
				</ul>
            </li>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">More<b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="https://github.com/sergiotaborda/lense-lang">Source Code</a></li>
			    <li><a href="https://groups.google.com/forum/#!forum/lense-lang">Discussion Group</a></li>
				
				<li><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>status.html">Roadmap &amp; Status</a></li>
              </ul>
            </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
	
	<div class="corner-ribbon top-right sticky shadow turquoise"><a href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>status.html">Experimentation Stage</a></div>
    
	<div class="container">
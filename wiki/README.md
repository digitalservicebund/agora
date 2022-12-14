# Installing

The following files need an updated copy, namespaced with the desired environment:

- [db_password.txt](db_password.txt) (e.g. db_password.test.txt)

deploy the stack (e.g. for test environment):

```Shell
env ENV=test HOST=test.agora-oegd.de docker stack deploy -c wiki.yml wiki --with-registry-auth
```


## Setup OIDC

- select PluggableAuth during installation
- select OpenID Connect during installation 
- select EmbedVideo during installation 

- first deploy stack without LocalSettings mounted 
- remove SQLLite from wizard

## Styling
- put this into Common.css:

```
#p-logo { display: none; }
#p-navigation { margin-top: 3em; }
```

## Videos
- We use Widget extension to embed Videos
- (as admin) create Page for Widget:YouTube and insert:

```
<noinclude>
This widget allows you to add a [https://developers.google.com/youtube/player_parameters YouTube video player] to your wiki page.

Created by [https://www.mediawikiwidgets.org/User:Yaron_Koren Yaron Koren] and extended by [https://www.mediawikiwidgets.org/User:Kghbln Karsten Hoffmeyer].

== Using this widget ==
For information on how to use this widget, see the [https://www.mediawikiwidgets.org/YouTube widget description page on MediaWikiWidgets.org].

== Copy to your site ==
To use this widget on your site, just install the [https://www.mediawiki.org/wiki/Extension:Widgets MediaWiki Widgets extension] and the copy [{{fullurl:{{FULLPAGENAME}}|action=edit}} full source code] of this page to your wiki, as an article called '''{{FULLPAGENAME}}'''.
</noinclude><includeonly><iframe width="<!--{$width|escape:'html'|default:'425'}-->" height="<!--{$height|escape:'html'|default:355}-->" src="https://www.youtube.com/embed/<!--{if isset($playlist)}-->?listType=playlist&list=<!--{$playlist|escape:'urlpathinfo'}--><!--{else}--><!--{$id|escape:'urlpathinfo'}--><!--{if isset($start)}-->?start=<!--{$start|escape:'urlpathinfo'}--><!--{/if}--><!--{/if}-->" style="border: none" allowfullscreen></iframe></includeonly>

```

- then use with:

```
{{#widget:YouTube|id=k_ezqjhtWYE|width=1120|height=630}}

```